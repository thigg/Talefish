#include "launcher.h"
#include <QFile>

Launcher::Launcher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{

}

QString Launcher::launch(const QString &program)
{
    m_process->start(program);
    m_process->waitForFinished(-1);
    QByteArray bytes = m_process->readAllStandardOutput();
    QString output = QString::fromLocal8Bit(bytes);
    return output;
}
void Launcher::launchAndForget(const QString &program, const QStringList &arguments)
{
    QProcess *forgettable = new QProcess(this);

    forgettable->startDetached(program, arguments);
}

bool Launcher::fileExists(const QString &path)
{
    QFile file(path);
    return file.exists();
}
Launcher::~Launcher() {

}
