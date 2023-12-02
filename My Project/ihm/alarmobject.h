#ifndef ALARMOBJECT_H
#define ALARMOBJECT_H

#include <QObject>

class AlarmObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString datetime READ datetime WRITE setDateTime NOTIFY datetimeChanged)
    Q_PROPERTY(QString info     READ info     WRITE setInfo     NOTIFY infoChanged)
    Q_PROPERTY(quint32 id       READ id       WRITE setId       NOTIFY idChanged)

public:
    explicit AlarmObject(QObject *parent = nullptr);
    AlarmObject(quint32 id, const QString _datetime, const QString _info, QObject *parent=nullptr);

    QString datetime() const { return m_datetime; }
    void setDateTime(const QString &);

    QString info() const { return m_info; }
    void setInfo(const QString &);

    quint32 id() const { return m_id; }
    void setId(const quint32 &);

private:
    quint32 m_id;
    QString m_datetime;
    QString m_info;

signals:
    void datetimeChanged();
    void infoChanged();
    void idChanged();


public slots:

};

#endif // ALARMOBJECT_H
