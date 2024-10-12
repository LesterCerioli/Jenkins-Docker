#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

// Configuração de autenticação
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('admin', 'af9cf97aab0240f3b67feebf0dbbed7f')
instance.setSecurityRealm(hudsonRealm)

// Configuração de autorização
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

instance.save()
