#include "handlehistory.h"

#include <QFile>
#include <QTextStream>

HandleHistory::HandleHistory(QObject *) : QObject()
{
}

void HandleHistory::cppSlotHandleHistory(QString name)
{
    QString inputFileName = name + ".log";

    QFile file(inputFileName);
    file.open(QIODevice::ReadWrite | QIODevice::Text);
    QTextStream inStream(&file);

    while (!inStream.atEnd()) {
        QString line = inStream.readLine();

        if (line.size() > 0) {
            QString dateTime, username, message;
            dateTime = line.section(";", 0, 0);
            username = line.section(";", 1, 1);
            message = line.section(";", 2);

            emit cppSignalSetHistoy(dateTime + " " + username + ": " + message);
        }
    }

    file.close();
}
