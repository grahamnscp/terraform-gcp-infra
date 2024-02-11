#/bin/bash -x

TMP_FILE=/tmp/load-tf-output.tmp.$$

# Collect node details from terraform output
CWD=`pwd`
cd ../tf
terraform output > $TMP_FILE
cd $CWD

# Some parsing into shell variables and arrays
DATA=`cat $TMP_FILE |sed "s/'//g"|sed 's/\ =\ /=/g'`
DATA2=`echo $DATA |sed 's/\ *\[/\[/g'|sed 's/\[\ */\[/g'|sed 's/\ *\]/\]/g'|sed 's/\,\ */\,/g'`

for var in `echo $DATA2`
do
  var_name=`echo $var | awk -F"=" '{print $1}'`
  var_value=`echo $var | awk -F"=" '{print $2}'|sed 's/\]//g'|sed 's/\[//g' |sed 's/\"//g'`
  #echo TF_OUTPUT: $var_name: $var_value

  case $var_name in

    "instance-name")
      NODES_PUBLIC_NAMES="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        NODE_NAME[$COUNT]=$entry
      done
      NUM_NODES=$COUNT
      ;;

    "instance-private-ip")
      NODES_PRIVATE_IPS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        NODE_PRIVATE_IP[$COUNT]=$entry
      done
      ;;

    "instance-public-ip")
      NODES_PUBLIC_IP="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        NODE_PUBLIC_IP[$COUNT]=$entry
      done
      ;;

  esac
done

# Tidy up
/bin/rm $TMP_FILE

