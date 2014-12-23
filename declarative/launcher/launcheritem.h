/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2014 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#ifndef LAUNCHERITEM_H
#define LAUNCHERITEM_H

#include <QtCore/QObject>
#include <KService/KService>

class LauncherItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString iconName READ iconName CONSTANT)
    Q_PROPERTY(QString appId READ appId CONSTANT)
    Q_PROPERTY(bool pinned READ isPinned WRITE setPinned NOTIFY pinnedChanged)
    Q_PROPERTY(bool running READ isRunning NOTIFY runningChanged)
    Q_PROPERTY(bool active READ isActive NOTIFY activeChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(int progress READ progress NOTIFY progressChanged)
public:
    LauncherItem(const QString &appId, QObject *parent = 0);

    QString name() const;
    QString iconName() const;
    QString appId() const;

    bool isPinned() const;
    void setPinned(bool value);

    bool isRunning() const;

    bool isActive() const;

    int count() const;
    int progress() const;

Q_SIGNALS:
    void pinnedChanged();
    void runningChanged();
    void activeChanged();
    void countChanged();
    void progressChanged();

private:
    QString m_appId;
    bool m_pinned;
    int m_count;
    int m_progress;
    KService::Ptr m_service;
};

#endif // LAUNCHERITEM_H
