#include "channelmodel.h"
#include "programmodel.h"

#include <QDir>
#include <QFileInfo>
#include <QFile>
#include <QXmlStreamReader>
#include <QDateTime>

#ifdef DEBUG
#include <QDebug>
#endif

class XmlParser
{
public:
    XmlParser(const QByteArray &data) : isProgramValid(false)
    {
        m_reader.addData(data);
        parseXmlStream();
    }

    Channel channel() const
    {
        return m_channel;
    }

    QList<Program> programs() const
    {
        return m_programs;
    }

private:
    void parseXmlStream();

private:
    QXmlStreamReader m_reader;
    Channel m_channel;
    QString m_currentToken;
    QList<Program> m_programs;
    Program m_currentProgram;
    bool isProgramValid;
};

void XmlParser::parseXmlStream()
{
    while (!m_reader.atEnd()) {
        if (m_reader.readNext()) {

            if (m_reader.isEndElement()) {
                if (isProgramValid) {
                    m_programs.append(m_currentProgram);
                    isProgramValid = false;
                }
                m_currentToken.clear();
                return;
            }

            if (m_reader.isCharacters()) {
                if (m_currentToken == QLatin1String("title"))
                    m_currentProgram.setName(m_reader.text().toString());
                else if (m_currentToken == QLatin1String("display-name"))
                    m_channel.setName(m_reader.text().toString());
            }

            if (m_reader.isStartElement()) {
                m_currentToken = m_reader.name().toString();
                if (m_currentToken == QLatin1String("icon")) {
                    QXmlStreamAttributes attribs = m_reader.attributes();
                    foreach (QXmlStreamAttribute attr, attribs) {
                        const QString attrName = attr.name().toString();
                        const QString attrValue = attr.value().toString();
                        if (attrName == QLatin1String("src"))
                            m_channel.setIcon(QUrl(attrValue));
                    }
                } else if (m_currentToken == QLatin1String("programme")) {
                    isProgramValid = true;
                    QXmlStreamAttributes attribs = m_reader.attributes();
                    foreach (QXmlStreamAttribute attr, attribs) {
                        const QString attrName = attr.name().toString();
                        const QString attrValue = attr.value().toString();
                        if (attrName == QLatin1String("start")) {
                            QDateTime dt = QDateTime::fromString(attrValue, QLatin1String("yyyyMMddhhmmss"));
                            m_currentProgram.setStartTime(dt.toLocalTime().toString(QLatin1String("hh:mm")));
                        }
                    }
                }

                parseXmlStream();
            }
        }
    }
}

ChannelModel::ChannelModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

void ChannelModel::init(const QString &channelDirectory)
{
    QDir channelDir(channelDirectory);
    const QFileInfoList channels = channelDir.entryInfoList(QDir::Files);
    int index = 1;
    foreach (const QFileInfo &fi, channels) {
        QFile file(fi.canonicalFilePath());
        if (!file.open(QIODevice::ReadOnly))
            continue;
        XmlParser parser(file.readAll());
        Channel channel = parser.channel();
        channel.setNumber(index++);
        m_channels.append(channel);

        QList<Program> programs = parser.programs();
        m_channelProgramMap.insert(channel.name(), new ProgramModel(programs));
        m_channelProgramSummaryMap.insert(channel.name(), new ProgramModel(programs, 2));

#ifdef DEBUG
    foreach (const Channel &ch, m_channels) {
        qDebug() << ch.name() << ch.icon();
        const QList<Program> programs = parser.programs();
        foreach (const Program &p, programs)
            qDebug() << p.name() << p.startTime();
        qDebug() << "--------------------------";
    }
#endif
    }
    emit initialized();
}

int ChannelModel::rowCount(const QModelIndex &/*parent*/) const {
    return m_channels.count();
}

QVariant ChannelModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_channels.count())
        return QVariant();

    const Channel &channel = m_channels[index.row()];
    if (role == NameRole)
        return channel.name();
    else if (role == NumberRole)
        return channel.number();
    else if (role == IconRole)
        return channel.icon();
    else if (role == ProgramSummaryRole)
        return QVariant::fromValue(m_channelProgramSummaryMap.value(channel.name()));
    else if (role == ProgramRole)
        return QVariant::fromValue(m_channelProgramMap.value(channel.name()));

    return QVariant();
}

QHash<int, QByteArray> ChannelModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "channelName";
    roles[NumberRole] = "channelNumber";
    roles[IconRole] = "channelIcon";
    roles[ProgramRole] = "channelProgram";
    roles[ProgramSummaryRole] = "channelProgramSummary";
    return roles;
}
