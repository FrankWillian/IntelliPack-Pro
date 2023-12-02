#include "alarmobject.h"

/**
 * @brief AlarmObject::AlarmObject
 * @param parent
 */
AlarmObject::AlarmObject(QObject *parent) : QObject(parent)
{ }

/**
 * @brief AlarmObject::AlarmObject
 * @param id
 * @param _datetime
 * @param _info
 * @param parent
 */
AlarmObject::AlarmObject(quint32 id, const QString _datetime, const QString _info, QObject *parent)
    : QObject(parent), m_id(id), m_datetime(_datetime), m_info(_info)
{

}

/**
 * @brief AlarmObject::setDateTime
 * @param dt
 */
void AlarmObject::setDateTime(const QString &dt)
{
    if ( dt != m_datetime )
    {
        m_datetime = dt;
        emit datetimeChanged();
    }
}

/**
 * @brief AlarmObject::setInfo
 * @param info
 */
void AlarmObject::setInfo(const QString &info)
{
    if ( info != m_info )
    {
        m_info = info;
        emit infoChanged();
    }

}

/**
 * @brief AlarmObject::setId
 * @param id
 */
void AlarmObject::setId(const quint32 &id)
{
    if ( id != m_id )
    {
        m_id = id;
        emit idChanged();
    }

}
