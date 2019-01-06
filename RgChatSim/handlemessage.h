#ifndef HANDLEMESSAGE_H
#define HANDLEMESSAGE_H

#include <QObject>
#include <QVariant>

extern QStringList filterWords;

class HandleMessage : public QObject
{
    Q_OBJECT

public:
    explicit HandleMessage(QObject *parent = nullptr);
    void logMessageToFile(QString fileName, QString logMessage);
    QString filterWords(QString in);

public slots:
    void cppSlotHandleSubmitMessage(QString fromUsername, QString toUsername, const QString& message);

signals:
    void cppSignalSetMessageBlock(QVariant name, QVariant message);
};

#endif // HANDLETEXTFIELD_H
