FROM teamcloudyuga/python:alpine
COPY . /usr/src/app
WORKDIR /usr/src/app
ENV LINK http://www.kardasa.pl
ENV TEXT1 KardasA
ENV TEXT2 Testowa Aplikacja!
ENV LOGO http://www.kardasa.pl/uploads/images/CV/KardasA_Small.jpg
ENV COMPANY OpenAdmin.pl
RUN pip3 install -r requirements.txt
CMD python rsvp.py
