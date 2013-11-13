#include <QtGui/QGuiApplication>
#include <QtQml/QQmlContext>
#include "qtquick2applicationviewer.h"
#include "channelmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ChannelModel model;

    QtQuick2ApplicationViewer viewer;
    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("channelModel", &model);
    viewer.setSource(QStringLiteral("qml/videoDemo/detailedListTest.qml"));
    viewer.showExpanded();

    model.init(":/channel/data");

    return app.exec();
}
