import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "dialog.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        id: mainpage
        title: i18n.tr("dialog")

        Component {
            id: dialog
            Dialog {
                id: dialogue
                title: "Save file"
                text: "Are you sure that you want to save this file?"
                Button {
                    text: "cancel"
                    onClicked: PopupUtils.close(dialogue)
                }
                Button {
                    text: "overwrite previous version"
                    color: UbuntuColors.orange
                    onClicked: PopupUtils.close(dialogue)
                }
                Button {
                    text: "save a copy"
                    color: UbuntuColors.orange
                    onClicked: {
                        console.log("caller: " + caller );
                        if ( caller !== null ) {
                            caller.callback("file is saved!");
                        }

                        PopupUtils.close(dialogue);
                    }
                }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: units.gu(2)

            Button {
                id: saveButton
                text: "save"
                onClicked: PopupUtils.open(dialog)

                function callback(message) {
                    console.log("returned: " + message);
                }
            }

            Button {
                id: anotherSave
                text: "Another Save"
                onClicked: PopupUtils.open(dialog, anotherSave)

                function callback(message) {
                    console.log("returned: " + message);
                }
            }

            Button {
                id: mydialog
                text: "My customized dialog"
                onClicked: {
                    Qt.createComponent("Dialog.qml").createObject(mainpage, {});
                }
            }

            Button {
                id: myanotherdialog
                text: "My another dialog"
                onClicked: {
                    dialog1.visible = true;
                }
            }
        }


        AnotherDialog {
            id: dialog1
            anchors.fill: parent
            visible: false
        }
    }
}

