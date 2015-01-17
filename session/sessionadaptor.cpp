/****************************************************************************
 * This file is part of Hawaii.
 *
 * Copyright (C) 2015 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *
 * $BEGIN_LICENSE:GPL2+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include "sessionadaptor.h"
#include "sessionmanager.h"

SessionAdaptor::SessionAdaptor(SessionManager *sessionManager)
    : QDBusAbstractAdaptor(sessionManager)
    , m_sessionManager(sessionManager)
    , m_powerManager(new PowerManager(this))
    , m_actionRequested(PowerManager::None)
{
    // When an action is requested we first log out (which means killing
    // the processes and quitting the compositor), when the session is
    // logged out this slot is called and perform the actual action
    connect(m_sessionManager, SIGNAL(loggedOut()),
            this, SLOT(performAction()));
}

bool SessionAdaptor::canLogOut()
{
    // Always true, but in the future we might consider blocking
    // logout; might come in handy for kiosk systems
    return true;
}

bool SessionAdaptor::canPowerOff()
{
    return m_powerManager->capabilities() & PowerManager::PowerOff;
}

bool SessionAdaptor::canRestart()
{
    return m_powerManager->capabilities() & PowerManager::Restart;
}

bool SessionAdaptor::canSuspend()
{
    return m_powerManager->capabilities() & PowerManager::Suspend;
}

bool SessionAdaptor::canHibernate()
{
    return m_powerManager->capabilities() & PowerManager::Hibernate;
}

bool SessionAdaptor::canHybridSleep()
{
    return m_powerManager->capabilities() & PowerManager::HybridSleep;
}

void SessionAdaptor::logOut()
{
    m_sessionManager->logOut();
    ::exit(EXIT_SUCCESS);
}

void SessionAdaptor::powerOff()
{
    m_actionRequested = PowerManager::PowerOff;
    logOut();
}

void SessionAdaptor::restart()
{
    m_actionRequested = PowerManager::Restart;
    logOut();
}

void SessionAdaptor::suspend()
{
    m_powerManager->suspend();
}

void SessionAdaptor::hibernate()
{
    m_powerManager->hibernate();
}

void SessionAdaptor::hybridSleep()
{
    m_powerManager->hybridSleep();
}

void SessionAdaptor::performAction()
{
    switch (m_actionRequested) {
    case PowerManager::PowerOff:
        m_powerManager->powerOff();
        break;
    case PowerManager::Restart:
        m_powerManager->restart();
        break;
    default:
        break;
    }
}

#include "moc_sessionadaptor.cpp"
