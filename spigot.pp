#installs spigot and dependancies and runs

service { 'sshd':
  ensure => running,
  enable => true,
}

file { '/opt/spigot':
  ensure => directory,
  mode => 0755,
}

file { '/opt/spigot/eula.txt':
  ensure => file,
  content => "eula=true\n",
  require => File['/opt/spigot'],
}

#java/openjre 8 package
package { 'openjdk-8-jre-headless':
  ensure => installed,
}

package { 'git':
  ensure => installed,
}

#https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#git config --global --unset core.autocrlf
#java -jar BuildTools.jar --rev latest

#in older versions of puppet, require was necessary, however in newer versions this is for the most part deprecated since puppet files are executed sequentially
service { 'spigot':
  ensure => running,
  enable => true,
  require => [Package['git'], File['/opt/spigot/eula.txt']]
}
