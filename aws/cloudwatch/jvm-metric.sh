#!/bin/bash
export DAEMOON_KEYWOARD=Test
export NAMESPACE=JVM
# Unit must be a value in the set [ Seconds, Microseconds, Milliseconds, Bytes, Kilobytes, Megabytes, Gigabytes, Terabytes, Bits, Kilobits, Megabits, Gigabits
#                                 , Terabits, Percent, Count, Bytes/Second, Kilobytes/Second, Megabytes/Second, Gigabytes/Second, Terabytes/Second, Bits/Second
#                                 , Kilobits/Second, Megabits/Second, Gigabits/Second, Terabits/Second, Count/Second, None ]
export UNIT=Megabytes

export REGION=$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | grep -i region | awk -F\" '{print $4}')
export INSTANCE_TYPE=$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | grep -i instanceType | awk -F\" '{print $4}')
export INSTANCE_ID=$(curl --silent http://169.254.169.254/latest/meta-data/instance-id)

export c=$(ps aux|grep java|grep $DAEMOON_KEYWOARD)
export free=0
export total=0
export using=0
# -z is when condition null return true , -n is not null reutrn true.
if [[ -n $c ]];then
  export free=$(ps aux|grep java|grep $DAEMOON_KEYWOARD|awk '{print $2}'|xargs jstat -gc |tail -n1 |awk {'print ($1+$2+$5+$7-$3-$4-$6-$8)/1024'})
  export total=$(ps aux|grep java|grep $DAEMOON_KEYWOARD|awk '{print $2}'|xargs jstat -gc |tail -n1 |awk {'print ($1+$2+$5+$7)/1024'})
  export using=$(ps aux|grep java|grep $DAEMOON_KEYWOARD|awk '{print $2}'|xargs jstat -gc |tail -n1 |awk {'print ($3+$4+$6+$8)/1024'})
fi

# put free heap size
aws cloudwatch put-metric-data --region $REGION \
                              --namespace $NAMESPACE \
                              --metric-name HeapFree \
                              --unit $UNIT \
                              --value $free \
                              --dimensions InstanceId=$INSTANCE_ID,InstanceType=$INSTANCE_TYPE

# put total heap size
aws cloudwatch put-metric-data --region $REGION \
                              --namespace $NAMESPACE \
                              --metric-name HeapTotal \
                              --unit $UNIT \
                              --value $total \
                              --dimensions InstanceId=$INSTANCE_ID,InstanceType=$INSTANCE_TYPE

# put using heap size
aws cloudwatch put-metric-data --region $REGION \
                              --namespace $NAMESPACE \
                              --metric-name HeapUsing \
                              --unit $UNIT \
                              --value $using \
                              --dimensions InstanceId=$INSTANCE_ID,InstanceType=$INSTANCE_TYPE
