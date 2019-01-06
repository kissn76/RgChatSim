#include "handlemessage.h"
#include "handlehistory.h"
#include "wordfilter.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

QStringList filterWords;

int main(int argc, char *argv[])
{
    filterWords = WordFilter::loadFilterWords();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon("rgnet.jpg"));

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    HandleMessage cppHandleMessage;
    HandleHistory cppHandleHistory;

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *qmlWindow = qobject_cast<QQuickWindow *>(topLevel);

    // connect QML signals to C++ slots
    QObject::connect(qmlWindow, SIGNAL(qmlSignalSubmitMessage(QString, QString, QString)),
                        &cppHandleMessage, SLOT(cppSlotHandleSubmitMessage(QString, QString, QString)));
    QObject::connect(qmlWindow, SIGNAL(qmlSignalGetHistory(QString)),
                        &cppHandleHistory, SLOT(cppSlotHandleHistory(QString)));

    // connect C++ signals to QML slots
    QObject::connect(&cppHandleMessage, SIGNAL(cppSignalSetMessageBlock(QVariant, QVariant)),
                     qmlWindow, SLOT(qmlSlotSetMessageBlock(QVariant, QVariant)));
    QObject::connect(&cppHandleHistory, SIGNAL(cppSignalSetHistoy(QVariant)),
                     qmlWindow, SLOT(qmlSlotSetHistoryBlock(QVariant)));

    return app.exec();
}
