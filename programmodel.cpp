#include "programmodel.h"

#include <QDebug>

ProgramModel::ProgramModel(const QList<Program> &programs, int maxRows, QObject *parent) :
    QAbstractListModel(parent),
    m_maxRows(maxRows),
    m_programs(programs)
{
}

int ProgramModel::rowCount(const QModelIndex &/*parent*/) const
{
    return m_maxRows != -1 ? m_maxRows : m_programs.count();
}

QVariant ProgramModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_programs.count())
        return QVariant();

    const Program &program = m_programs[index.row()];
    if (role == NameRole)
        return program.name();
    else if (role == StartTimeRole)
        return program.startTime();
    return QVariant();
}

QHash<int, QByteArray> ProgramModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "programName";
    roles[StartTimeRole] = "startTime";
    return roles;
}
