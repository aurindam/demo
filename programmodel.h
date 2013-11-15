#ifndef PROGRAMMODEL_H
#define PROGRAMMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class Program
{
public:
    void setName(const QString &name) { m_name = name; }
    QString name() const { return m_name; }

    void setStartTime(const QString &time) { m_time = time; }
    QString startTime() const { return m_time; }

private:
    QString m_name;
    QString m_time;
};

class ProgramModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ProgramRoles {
        NameRole = Qt::UserRole + 1,
        StartTimeRole
    };

    explicit ProgramModel(const QList<Program> &programs, int maxRows = -1,
                          QObject *parent = 0);

    int rowCount(const QModelIndex & = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    int m_maxRows;
    QList<Program> m_programs;
    QStringList m_nextTwoStartTimes;
    QStringList m_nextTwoPrograms;
};

#endif // PROGRAMMODEL_H
