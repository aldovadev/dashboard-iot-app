import datetime
import sys
import serial

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QObject, pyqtSignal, pyqtSlot

class hmi(QObject):
    valSistem = False
    valSend = False
    outKecepatan = 0

    def __init__(self):
        QObject.__init__(self)
        self.initUART('COM7')
        self.initTimer()

    # Signal sending sum
    # Necessarily give the name of the argument through arguments=['']
    # Otherwise it will not be possible to get it up in QML
    valKecepatan = pyqtSignal(int, arguments=['kecepatan'])
    valTemp = pyqtSignal(float, arguments=['temp'])
    valCurrent = pyqtSignal(float, arguments=['current'])
    valVoltage = pyqtSignal(float, arguments=['voltage'])
    valBatt = pyqtSignal(int, arguments=['batt'])
    valPower = pyqtSignal(float, arguments=['power'])
    valDate = pyqtSignal(str, arguments=['date'])
    valTime = pyqtSignal(str, arguments=['time'])

    @pyqtSlot(int)
    def valSlider1(self, data):
        self.outKecepatan = data

    @pyqtSlot(bool)
    def valSendButton(self, data):
        self.ValSend = data

    @pyqtSlot(bool)
    def valSistemState(self, data):
        self.valSistem = data

    def initUART(self, port):
        baudrate = 9600
        try:
            self.ser = serial.Serial(
            port,
            baudrate,
            timeout=1,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS
            )
        except serial.SerialException as e:
            print("SERIAL NOT RESPONDING")
            #self.ser.close()
            sys.exit(-1)

    def initTimer(self):
        self.timer = QTimer()
        self.timer.setInterval(20)
        self.timer.timeout.connect(self.updateQml)
        self.timer.start()

    def updateQml(self):
        inData = self.ser.readline()
        arrayData = inData.split()
        if len(arrayData) >= 7:
            inButton1 = int(arrayData[0])
            inButton2 = int(arrayData[1])
            inKecepatan = int(arrayData[2])
            inTemp = float(arrayData[3])
            inCurrent = float(arrayData[4])
            inVoltage = float(arrayData[5])
            inBatt = int(arrayData[6])
            inPower = float(inVoltage)*float(inCurrent)

            inTemp = round(inTemp, 1)
            inCurrent = round(inCurrent, 1)
            inVoltage = round(inVoltage, 1)
            inPower = round(inPower, 1)

            #Emitting the data over pyqtSignal
            if self.valSistem == True:
                self.valKecepatan.emit(inKecepatan)
                self.valTemp.emit(inTemp)
                self.valCurrent.emit(inCurrent)
                self.valVoltage.emit(inVoltage)
                self.valPower.emit(inPower)
                self.valBatt.emit(inBatt)
            else:
                self.valKecepatan.emit(0)
                self.valTemp.emit(0.00)
                self.valCurrent.emit(0.00)
                self.valVoltage.emit(0.00)
                self.valPower.emit(0.00)
                self.valBatt.emit(0)

        DateTime = datetime.datetime.now()
        textDate = (DateTime.strftime("%A, %d %B %Y"))
        textTime = ('%s : %s : %s' % (DateTime.hour, DateTime.minute, DateTime.second))
        self.valDate.emit(textDate)
        self.valTime.emit(textTime)

if __name__ == "__main__":
    # Create an instance of the application
    app = QGuiApplication(sys.argv)
    # Create QML engine
    engine = QQmlApplicationEngine()
    # Create a calculator object
    x = hmi()
    # And register it in the context of QML
    engine.rootContext().setContextProperty("hmi", x)
    # Load the qml file into the engine
    engine.load("main.qml")

    engine.quit.connect(app.quit)
    sys.exit(app.exec_())
