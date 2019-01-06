#include "handlemessage.h"

#include <QDateTime>
#include <QFile>
#include <QTextStream>
#include <QRegularExpression>

/*
 * This class handles interactions with the text field
 */
HandleMessage::HandleMessage(QObject *) : QObject()
{
}

void HandleMessage::cppSlotHandleSubmitMessage(QString fromUsername, QString toUsername, const QString &message)
{
    QString dateTime, filteredMessage, logMessage, fileName;

    fileName = toUsername + ".log";
    dateTime = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    filteredMessage = filterWords(message);
    logMessage = dateTime + ";" + fromUsername + ";" + filteredMessage;

    logMessageToFile(fileName, logMessage);

    emit cppSignalSetMessageBlock(toUsername, dateTime + " " + fromUsername + ": " + filteredMessage);
}


void HandleMessage::logMessageToFile(QString fileName, QString logMessage)
{
    QFile file(fileName);
    file.open(QFile::WriteOnly | QFile::Append);
    QTextStream out(&file);

    out << logMessage << endl;

    file.close();
}

QString HandleMessage::filterWords(QString in)
{
    std::for_each(::filterWords.begin(), ::filterWords.end(), [&in](QString word) {
        in.replace(QRegularExpression("\\b" + word + "\\b"), "*");
    });

    return in;
}
