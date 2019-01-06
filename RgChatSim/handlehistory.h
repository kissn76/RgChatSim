#ifndef HANDLEHISTORY_H
#define HANDLEHISTORY_H

#include <QObject>
#include <QVariant>

class HandleHistory : public QObject
{
    Q_OBJECT

public:
    explicit HandleHistory(QObject *parent = nullptr);

public slots:
    void cppSlotHandleHistory(QString name);

signals:
    void cppSignalSetHistoy(QVariant history);
};

#endif // HANDLEHISTORY_H
