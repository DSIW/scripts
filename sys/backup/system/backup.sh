#!/bin/bash
# Simple backup with rsync
# VERSION: 2011-02-22
# local-mode, tossh-mode, fromssh-mode

# sources and target MUST end WITH slash
SOURCES="/etc/ /home/ /var/www/ /var/lib/mysql/ /var/games/ /usr/local/bin/ /usr/local/sbin/ /opt/"
TARGET="/media/backup/"

RSYNCCONF="-av --progress --delete --exclude=.local/share/Trash/"

MOUNTPOINT="/media/backup"     # mountpoint must end WITHOUT slash
#PACKAGES=1
MONTHROTATE=1

#SSHUSER="root"
#SSHPORT=22
#FROMSSH="clientsystem"
#TOSSH="backupserver"

### do not edit ###

MOUNT="/bin/mount"; FGREP="/bin/fgrep"; SSH="/usr/bin/ssh"
LN="/bin/ln"; ECHO="/bin/echo"; DATE="/bin/date"; RM="/bin/rm"
DPKG="/usr/bin/dpkg"; AWK="/usr/bin/awk"; MAIL="/usr/bin/mail"
CUT="/usr/bin/cut"; TR="/usr/bin/tr"; RSYNC="/usr/bin/rsync"
LAST="last"; INC="--link-dest=../$LAST"

LOG=$0.log
$DATE > $LOG

if [ -n "$PACKAGES" ] && [ -z "$FROMSSH" ]; then
  $ECHO "$DPKG --get-selections | $AWK '!/deinstall|purge|hold/'|$CUT -f1 | $TR '\n' ' '" >> $LOG
  $DPKG --get-selections | $AWK '!/deinstall|purge|hold/'|$CUT -f1 |$TR '\n' ' '  >> $LOG  2>&1 
fi

MOUNTED=$($MOUNT | $FGREP "$MOUNTPOINT");
if [ -z "$MOUNTPOINT" ] || [ -n "$MOUNTED" ]; then
  if [ $MONTHROTATE ]; then
    TODAY=$($DATE +%d)
  else
    TODAY=$($DATE +%y%m%d)
  fi

  if [ "$SSHUSER" ] && [ "$SSHPORT" ]; then
    S="$SSH -p $SSHPORT -l $SSHUSER";
  fi

  for SOURCE in $($ECHO $SOURCES)
  do
    if [ "$S" ] && [ "$FROMSSH" ] && [ -z "$TOSSH" ]; then
      $ECHO "$RSYNC -e \"$S\" -avR $FROMSSH:$SOURCE $RSYNCCONF $TARGET$TODAY $INC"  >> $LOG 
      $RSYNC -e "$S" -avR $FROMSSH:$SOURCE $RSYNCCONF $TARGET$TODAY $INC >> $LOG 2>&1 
      if [ $? -ne 0];then
        ERROR=1
      fi 
    fi 
    if [ "$S" ]  && [ "$TOSSH" ] && [ -z "$FROMSSH" ]; then
      $ECHO "$RSYNC -e \"$S\" -avR $SOURCE $RSYNCCONF $TOSSH:$TARGET$TODAY $INC " >> $LOG
      $RSYNC -e "$S" -avR $SOURCE $RSYNCCONF $TOSSH:$TARGET$TODAY $INC >> $LOG 2>&1 
      if [ $? -ne 0];then
        ERROR=1
      fi 
    fi
    if [ -z "$S" ]; then
      $ECHO "$RSYNC -avR $SOURCE $RSYNCCONF $INC $TARGET$TODAY"  >> $LOG 
      $RSYNC -avR $SOURCE $RSYNCCONF $INC $TARGET$TODAY  >> $LOG 2>&1 
      if [ $? -ne 0 ];then
        ERROR=1
      fi 
    fi
  done

  if [ "$S" ] && [ "$TOSSH" ] && [ -z "$FROMSSH" ]; then
    $ECHO "$SSH -p $SSHPORT -l $SSHUSER $TOSSH $LN -nsf $TARGET$TODAY $TARGET$LAST" >> $LOG  
    $SSH -p $SSHPORT -l $SSHUSER $TOSSH "$LN -nsf $TARGET$TODAY $TARGET$LAST" >> $LOG 2>&1
    if [ $? -ne 0 ];then
      ERROR=1
    fi 
  fi 
  if ( [ "$S" ] && [ "$FROMSSH" ] && [ -z "$TOSSH" ] ) || ( [ -z "$S" ] );  then
    $ECHO "$LN -nsf $TARGET$TODAY $TARGET$LAST" >> $LOG
    $LN -nsf $TARGET$TODAY $TARGET$LAST  >> $LOG 2>&1 
    if [ $? -ne 0 ];then
      ERROR=1
    fi 
  fi
else
   $ECHO "$MOUNTPOINT not mounted" >> $LOG
   ERROR=1
fi
$DATE >> $LOG
if [ -n "$MAILREC" ];then
  if [ $ERROR ];then
    $MAIL -s "Error Backup $LOG" $MAILREC < $LOG
  else
    $MAIL -s "Backup $LOG" $MAILREC < $LOG
  fi
fi


