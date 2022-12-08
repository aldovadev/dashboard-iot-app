import QtQuick 2.8
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtQuick.Extras 1.4

Window {
    id: root
    width: 1280
    height: 800
    visible: true
    color: "#000000"
    title: qsTr("HMI Mobil Listrik")
    //visibility: "FullScreen"

    Image {
        id: image
        x: 0
        y: 0
        width: 1280
        height: 800
        source: "qml/Background.png"
        sourceSize.width: 1280
        sourceSize.height: 800
        fillMode: Image.PreserveAspectCrop

        Slider{
            id: slider1
            x: 96
            y:736
            width: 500
            height: 40
            to: 0
            from: 180
            rotation: 180
            onPositionChanged: hmi.valSlider1(slider1.value)
        }

        CircularGauge {
            id: gauge1
            x: 50
            y: 100
            width: 400
            height: 400
            opacity: 0.981
            stepSize: 0
            maximumValue: 180
        }
        Text {
            id: text6
            x: 215
            y: 456
            width: 68
            height: 44
            color: "#ffffff"
            text: qsTr("Kmh")
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            minimumPixelSize: 12
            font.bold: true
        }

        Text {
            id: text7
            x: 964
            y: 451
            width: 131
            height: 31
            color: "#ffffff"
            text: qsTr("x100 RPM")
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            minimumPixelSize: 12
        }

        Text {
            id: text8
            x: 210
            y: 412
            width: 78
            height: 46
            color: "#ffffff"
            text: "0"
            font.pixelSize: 36
            horizontalAlignment: Text.AlignHCenter
            font.bold: false
        }

        Text {
            id: text9
            x: 992
            y: 411
            width: 78
            height: 44
            color: "#ffffff"
            text: parseInt(slider1.value*2/3)
            font.pixelSize: 36
            horizontalAlignment: Text.AlignHCenter
            font.bold: false
        }

        CircularGauge {
            id: gauge2
            x: 830
            y: 100
            width: 400
            height: 400
            opacity: 0.981
            stepSize: 0
            maximumValue: 120
        }

        RoundButton {
            id: buttonStop
            x: 224
            y: 627
            width: 70
            height: 70
            text: "STOP"
            onClicked: {
                statusIndicatorGreen.active= false;
                statusIndicatorRed.active= true;
                delayButton.checked= false;
                hmi.valSistemState(false);
            }
        }

        DelayButton {
            id: delayButton
            x: 112
            y: 626
            width: 86
            height: 71
            text: qsTr("HOLD")
            delay: 2000
            onActivated: {
                statusIndicatorGreen.active =true;
                statusIndicatorRed.active=false;
                hmi.valSistemState(true);
            }
        }

        Text {
            id: text2
            x: 8
            y: 742
            width: 88
            height: 28
            color: "#ffffff"
            text: qsTr("SPEED:")
            font.pixelSize: 24
            font.bold: true
            styleColor: "#ffffff"

        }

        Text {
            id: text1
            x: 16
            y: 641
            width: 90
            height: 42
            color: "#ffffff"
            text: qsTr("START:")
            font.pixelSize: 24
            font.bold: true
            styleColor: "#ffffff"
            anchors.leftMargin: 3
        }

        StatusIndicator {
            id: statusIndicatorGreen
            x: 422
            y: 637
            color: "#16ff00"
            active: false
        }

        StatusIndicator {
            id: statusIndicatorRed
            x: 484
            y: 637
            active: true
        }

        Image {
            id: imageBatt
            x: 535
            y: 638
            width: 62
            height: 38
            source: "qml/batt.png"
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text5
            x: 541
            y: 682
            width: 51
            height: 22
            color: "#ffffff"
            text: qsTr("100 %")
            font.pixelSize: 16
            font.bold: true
            styleColor: "#ffffff"
        }

        Text {
            id: text11
            x: 634
            y: 626
            color: "#ffffff"
            text: qsTr("TEMP:")
            font.pixelSize: 26
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text12
            x: 809
            y: 625
            width: 110
            height: 37
            color: "#ffffff"
            text: qsTr("POWER:")
            font.pixelSize: 26
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text13
            x: 997
            y: 623
            width: 233
            height: 37
            color: "#ffffff"
            text: qsTr("VOLTAGE: 00.0 V")
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            font.bold: true
        }

        Text {
            id: text14
            x: 994
            y: 663
            width: 236
            height: 37
            color: "#ffffff"
            text: qsTr("CURRENT: 00.0 A")
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            font.bold: true
        }

        Text {
            id: text15
            x: 994
            y: 706
            width: 220
            height: 24
            color: "#ffffff"
            text: qsTr("Date: Sunday, 16 August 1998")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text16
            x: 992
            y: 747
            width: 231
            height: 23
            color: "#ffffff"
            text: qsTr("Time: Padang, 00 : 00 : 00 WIB")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text17
            x: 634
            y: 668
            color: "#ffffff"
            text: qsTr("00.0")
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: text18
            x: 809
            y: 668
            color: "#ffffff"
            text: qsTr("00.0")
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: text19
            x: 723
            y: 747
            color: "#ffffff"
            text: qsTr("*C")
            font.pixelSize: 24
            horizontalAlignment: Text.AlignRight
        }

        Text {
            id: text20
            x: 880
            y: 747
            color: "#ffffff"
            text: qsTr("Kwh")
            font.pixelSize: 24
            horizontalAlignment: Text.AlignRight
        }

        ToggleButton {
            id: toggleButton
            x: 324
            y: 623
            width: 72
            height: 78
            text: qsTr("SEND")
        }

        Connections{
            target: hmi

            onValKecepatan:{
                gauge1.value= kecepatan;
                text8.text= kecepatan;
                gauge2.value= kecepatan*2/3;
                text9.text= parseInt(kecepatan*2/3);
            }

            onValTemp:{
                text17.text= temp;
            }

            onValVoltage:{
                text13.text= "VOLTAGE: "+voltage+"   V";
            }

            onValCurrent:{
                text14.text= "CURRENT: "+current+"   A";
            }

            onValPower:{
                text18.text= power;
            }

            onValBatt:{
                text5.text= batt+" %";
            }

            onValDate:{
                text15.text= "Date: "+date;
            }

            onValTime:{
                text16.text= "Time: "+"Padang, "+time+" WIB";
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33}
}
##^##*/
