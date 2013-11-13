#ifndef CHANNELMODEL_H
#define CHANNELMODEL_H

#include "programmodel.h"

#include <QAbstractItemModel>
#include <QUrl>

class ProgramModel;
class Program;

class Channel
{
public:
    Channel() : m_number(-1)    {}

    void setName(const QString &name) { m_name = name; }
    QString name() const { return m_name; }

    void setNumber(int number) { m_number = number; }
    int number() const { return m_number; }

    void setIcon(const QUrl &url) { m_iconUrl = url; }
    QUrl icon() const { return m_iconUrl; }

private:
    QString m_name;
    int m_number;
    QUrl m_iconUrl;
};

class ChannelModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ChannelRoles {
        NameRole = Qt::UserRole + 1,
        NumberRole
    };

    explicit ChannelModel(QObject *parent = 0);

    void init(const QString &channelDirectory);

    int rowCount(const QModelIndex & = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE QObject *programModel(const QString &channelName) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:
    void initialized();

private:
    QList<Channel> m_channels;
    QMap<QString, QList<Program> > m_channelProgramMap;
};

#endif // CHANNELMODEL_H
