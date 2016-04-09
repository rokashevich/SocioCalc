import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
	id:root
	visible:true
	width:480
	height:800

	property int elementHeight:(height-toolBar.height)/model2.count

	property var result
	Component.onCompleted: recalculate()
	Rectangle {
		color: "#212126"
		anchors.fill: parent
	}

	toolBar: BorderImage {
		border.bottom: 4
		source: "images/toolbar.png"
		width: parent.width
		height: parent.parent.height*0.15
		Rectangle {
			color: "transparent"
			anchors.top: parent.top
			anchors.bottom: toolbar.top
			anchors.left: parent.left
			anchors.right: parent.right
			Text {
				width: parent.width
				height: parent.height
				fontSizeMode: Text.Fit
				font.pixelSize: parent.height
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				color: "white"
				text: {
					var string = ""
					for (var i=0;i<result.length;i++) {
						string+=names[result[i]][3]
						if (result.length !== 16 || i !== 7)
							string+=" "
						else
							string+="<br>"
					}
				}
			}
		}
		Rectangle {
			id: toolbar
			color:"transparent"
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			height: elementHeight
			Row {//снизу-слева
			anchors.fill: parent
			Image {
				source: "images/clear.png"
				height: parent.height
				width: height
				MouseArea {anchors.fill:parent;onClicked:{clear();recalculate()}}
			}
			}
		}
	}

	property var matrix: [
//                                                     квадра┐
//                 хладнокровные/страстные/деловые/душевные┐ │
//                агрессор/виктим/заботливый/инфантильный┐ │ │
//                           квестимность/деклатимность┐ │ │ │
//                     рассудительность/решительность┐ │ │ │ │
//                            весёлость/серьёзность┐ │ │ │ │ │
//                              процесс/результат┐ │ │ │ │ │ │
//                        позитивизм/негативизм┐ │ │ │ │ │ │ │
//                          статика/динакмика┐ │ │ │ │ │ │ │ │
//                        тактика/стратегия┐ │ │ │ │ │ │ │ │ │
//               конструктивизм/эмотивизм┐ │ │ │ │ │ │ │ │ │ │
//     беспечность/предусмотрительность┐ │ │ │ │ │ │ │ │ │ │ │
//             уступчивость/упрямство┐ │ │ │ │ │ │ │ │ │ │ │ │
//          демократия/аристократия┐ │ │ │ │ │ │ │ │ │ │ │ │ │
//иррациональность/рациональность┐ │ │ │ │ │ │ │ │ │ │ │ │ │ │
//     экстраверсия/интроверсия┐ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │
//         интуиция/сенсорика┐ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │
//             логика/этика┐ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │
													[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,2,0], //Дон
													[1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,2,3,0], //Дюм
													[1,1,0,1,0,1,1,0,0,1,0,1,0,0,1,2,1,0], //Гюго
													[0,0,1,1,0,1,1,1,1,0,1,1,0,0,0,3,1,0], //Роб

													[1,0,0,1,1,1,0,0,1,1,1,0,0,1,0,0,1,1], //Гам
													[0,1,1,1,1,1,0,1,0,0,0,0,0,1,1,1,1,1], //Макс
													[0,1,0,0,1,0,1,0,1,0,1,1,0,1,1,1,2,1], //Жук
													[1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,0,3,1], //Есь

													[1,1,0,0,0,1,1,1,1,0,0,0,1,1,0,1,1,2], //Нап
													[0,0,1,0,0,1,1,0,0,1,1,0,1,1,1,0,1,2], //Баль
													[0,0,0,1,0,0,0,1,1,1,0,1,1,1,1,0,2,2], //Джек
													[1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,1,3,2], //Драй

													[0,1,0,1,1,0,1,1,0,1,1,0,1,0,0,2,1,3], //Штир
													[1,0,1,1,1,0,1,0,1,0,0,0,1,0,1,3,3,3], //Дост
													[1,0,0,0,1,1,0,1,0,0,1,1,1,0,1,3,2,3], //Гек
													[0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,2,1,3]  //Габ
	]
	property var names: [
		["ИЛЭ", "ENTP", "Дон Кихот",      "Дон",  "Интуитивно-логический экстраверт", "Искатель"       ],
		["СЭИ", "ISFP", "Дюма",           "Дюм",  "Сенсорно-этический интроверт",     "Посредник"      ],
		["ЭСЭ", "ESFJ", "Гюго",           "Гюго", "Этико-сенсорный экстраверт",       "Энтузиаст"      ],
		["ЛИИ", "INTJ", "Робеспьер",      "Роб",  "Логико-интуитивный интроверт",     "Аналитик"       ],

		["ЭИЭ", "ENFJ", "Гамлет",         "Гам",  "Этико-интуитивный экстраверт",     "Наставник"      ],
		["ЛСИ", "ISTJ", "Максим Горький", "Макс", "Логико-сенсорный интроверт",       "Инспектор"      ],
		["СЛЭ", "ESTP", "Жуков",          "Жук",  "Сенсорно-логический экстраверт",   "Маршал"         ],
		["ИЭИ", "INFP", "Есенин",         "Есь",  "Интуитивно-этический интроверт",   "Лирик"          ],

		["СЭЭ", "ESFP", "Наполеон",       "Нап",  "Сенсорно-этический экстраверт",    "Политик"        ],
		["ИЛИ", "INTP", "Бальзак",        "Баль", "Интуитивно-логический интроверт",  "Критик"         ],
		["ЛИЭ", "ENTJ", "Джек Лондон",    "Джек", "Логико-интуитивный экстраверт",    "Предприниматель"],
		["ЭСИ", "ISFJ", "Драйзер",        "Драй", "Этико-сенсорный интроверт",        "Хранитель"      ],

		["ЛСЭ", "ESTJ", "Штирлиц",        "Штир", "Логико-сенсорный экстраверт",      "Администратор"  ],
		["ЭИИ", "INFJ", "Достоевский",    "Дост", "Этико-интуитивный интроверт",      "Гуманист"       ],
		["ИЭЭ", "ENFP", "Гексли",         "Гек",  "Интуитивно-этический экстраверт",  "Советчик"       ],
		["СЛИ", "ISTP", "Габен",          "Габ",  "Сенсорно-логический интроверт",    "Мастер"         ]
	]
	ListModel {
		id: model2
		ListElement{choice:-1;auto:false;one:"Логика";          two:"Этика"}               //0
		ListElement{choice:-1;auto:false;one:"Интуиция";        two:"Сенсорика"}           //1
		ListElement{choice:-1;auto:false;one:"Экстраверсия";    two:"Интроверсия"}         //2
		ListElement{choice:-1;auto:false;one:"Иррациональность";two:"Рациональность"}      //3
		ListElement{choice:-1;auto:false;one:"Демократизм";     two:"Аристократизм"}       //4
		ListElement{choice:-1;auto:false;one:"Уступчивость";    two:"Упрямство"}           //5
		ListElement{choice:-1;auto:false;one:"Беспечность";     two:"Предусмотрительность"}//6
		ListElement{choice:-1;auto:false;one:"Конструктивизм";  two:"Эмотивизм"}           //7
		ListElement{choice:-1;auto:false;one:"Тактика";         two:"Стратегия"}           //8
		ListElement{choice:-1;auto:false;one:"Статика";         two:"Динамика"}            //9
		ListElement{choice:-1;auto:false;one:"Позитивизм";      two:"Негативизм"}          //10
		ListElement{choice:-1;auto:false;one:"Процесс";         two:"Результат"}           //11
		ListElement{choice:-1;auto:false;one:"Веселость";       two:"Серьезность"}         //12
		ListElement{choice:-1;auto:false;one:"Рассудительность";two:"Решительность"}       //13
		ListElement{choice:-1;auto:false;one:"Квестимность";    two:"Деклатимность"}       //14
	}
	ListModel {
		id: model4
		ListElement{choice:-1;auto:false;one:"Агрессор";     two:"Виктим";   three:"Заботливый";four:"Инфантильный"}//15
		ListElement{choice:-1;auto:false;one:"Хладнокровные";two:"Страстные";three:"Деловые";   four:"Душевные"}    //16
		ListElement{choice:-1;auto:false;one:"1 квадра";     two:"2 квадра"; three:"3 квадра";  four:"4 квадра"}    //17
	}

	function recalculate() {
		result = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
		for (var i=0;i<model2.count;i++) { //проходим по всем ПР в модели
			if (model2.get(i).auto) {
				model2.get(i).auto = false
				model2.get(i).choice = -1
			}
			var r = []
			for (var j=0;j<result.length;j++) {
				if (model2.get(i).choice === matrix[result[j]][i] || model2.get(i).choice === -1) {
					r.push(result[j])
				}
			}
		result = r
		}
		for (i=0;i<model2.count;i++) {
		if (model2.get(i).choice !== -1)
			continue
		var left = false
		var right = false
		for (j=0;j<result.length;j++) {
			if      (matrix[result[j]][i] === 0) left  = true
			else if (matrix[result[j]][i] === 1) right = true
		}
		if (left & !right) {
			model2.get(i).choice = 0
			model2.get(i).auto = true
		} else if (!left & right) {
			model2.get(i).choice = 1
			model2.get(i).auto = true
		}
		}
	}

	function clear() {
		for (var i=0;i<model2.count;i++) {
		model2.get(i).auto = false
		model2.get(i).choice = -1
		}
	}

	StackView {
		id: stackView
		anchors.fill: parent
		initialItem: calculator
	}
	Component {
		id: calculator
		ListView {
			width: parent.width
			height: parent.height
			model: model2
			delegate: buttonRowDelegate
		}
	}

	Component {
		id: buttonRowDelegate
		Row {
			anchors.left: parent.left
			anchors.right: parent.right
			height: elementHeight
			Button {
				property int col: 0
				property var rowmodel: model
				width: parent.width/2
				height: parent.height
				enabled: !model.auto
				onClicked: {model2.get(index).choice===col?model2.get(index).choice=-1:model2.get(index).choice=col;recalculate()}
				style: buttonStyle
			}
			Button {
				property int col: 1
				property var rowmodel: model
				width: parent.width/2
				height: parent.height
				enabled: !model.auto
				onClicked: {model2.get(index).choice===col?model2.get(index).choice=-1:model2.get(index).choice=col;recalculate()}
				style: buttonStyle
			}
		}
	}

	Component {
		id: buttonStyle
		ButtonStyle {
			panel: Item {
				BorderImage {
					anchors.fill: parent
					antialiasing: true
					border.bottom: 10
					border.top: 10
					border.left: 10
					border.right: 104
					source: {
						if (parent.parent.parent.rowmodel.auto && parent.parent.parent.col === parent.parent.parent.rowmodel.choice)
							"../images/button_autopressed.png"
						else
							if (parent.parent.parent.col === parent.parent.parent.rowmodel.choice)
								"../images/button_pressed.png"
							else
								"../images/button_default.png"
					}
					Text {
						text: parent.parent.parent.parent.col === 0 ? parent.parent.parent.parent.rowmodel.one : parent.parent.parent.parent.rowmodel.two
						anchors.centerIn: parent
						color: "white"
						opacity: parent.parent.parent.enabled ? 1.0 : 0.5
						font.pixelSize: elementHeight/3
						renderType: Text.NativeRendering
					}
				}
			}
		}
	}
}
