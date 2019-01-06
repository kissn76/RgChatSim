#include "wordfilter.h"

#include <QFile>
#include <QTextStream>

QStringList WordFilter::loadFilterWords()
{
    QStringList wordfilter;
    QString inputFileName = "wordfilter.txt";

    QFile file(inputFileName);
    file.open(QIODevice::ReadWrite | QIODevice::Text);
    QTextStream inStream(&file);

    while (!inStream.atEnd()) {
        QString line = inStream.readLine();
        wordfilter << line;
    }

    file.close();

    return wordfilter;
}
