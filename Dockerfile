FROM mottosso/mayabase-centos
 
MAINTAINER marcus@abstractfactory.io
 
# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget http://download.autodesk.com/us/support/files/maya_2015_service_pack_5/Autodesk_Maya_2015_SP5_English_Linux.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz

WORKDIR /maya
 
# Install Maya
RUN rpm -Uvh *.rpm

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya2015-x64/
ENV PATH=$MAYA_LOCATION/bin:$PATH

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    mayapy get-pip.py

RUN mayapy -m pip install \
 nose

# Cleanup
WORKDIR /root
RUN rm -r /maya
