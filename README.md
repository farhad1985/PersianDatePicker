## PersianDatePicker

 PersianDatePicker written in Swift
 
 <img src="https://raw.githubusercontent.com/farhad1985/PersianDatePicker/master/ScreenShot/demo.gif"  height="668" width="375" />


### Requirements

   - iOS 9.0+ 
   - Xcode 8.1+
   - Swift 3.0+

### Install

you can use in cocoapods
```swift
pod 'PersianDatePicker'
```


<img src="https://raw.githubusercontent.com/farhad1985/PersianDatePicker/master/ScreenShot/Simulator%20Screen%20Shot%20May%208%2C%202017%2C%201.29.54%20PM.jpg"  height="242" width="442" />


### StoryBoard
you can use in the storyboard, you add a UIView in your ViewController and inherit from [ PersianDatePickerView ]

<img src="https://github.com/farhad1985/PersianDatePicker/blob/master/ScreenShot/Screen%20Shot%202017-05-08%20at%201.30.16%20PM.png" height="202" width="442" />

### Style
you can use pickerStyle for two types . 

<img src="https://raw.githubusercontent.com/farhad1985/PersianDatePicker/master/ScreenShot/Simulator%20Screen%20Shot%20Jul%2029%2C%202017%2C%2011.17.23%20AM.png" height="202" width="442" />

```swift
 persianDatePicker.style = .short
```

for set Font :

```swift
 persianDatePicker.font = UIFont(name: "IRANSansMobileFaNum-Light", size: 18)
```

### How to use in the code

It's very simple. 

```swift
import PersianDatePicker
```

```swift
@IBOutlet weak var txtDate: UITextField!
```

```swift
let persianDatePicker = PersianDatePickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
txtDate.inputView = persianDatePicker

persianDatePicker.onChange = { (year, month, day) in
    self.txtDate.text = "\(year)/\(month)/\(day)"
}
```
if you want to set years range:

```swift
persianDatePickerView.setYearsRange(fromYear : 1390 , toYear : 1400)
```

if you want to have persian date:

```swift
persianDatePickerView.getPersianDate()
```

and if you want to have gregorian date:

```swift
persianDatePickerView.getGregorianDate()
```


you can have next day or back day :

```swift
guard let persianDate = persianDatePickerView.getPersianDate() else {return}
self.persianDatePickerView.nextDay(by: persianDate)
```

if you want to use of dialog: 

<img src="https://raw.githubusercontent.com/farhad1985/PersianDatePicker/master/ScreenShot/dialog.jpeg"  height="400" width="375"  />

```swift
let pView = PersianDatePickerPresenter()
pView.show(in: self) { persianDate in
   print(persianDate)
}
```
please download example and test it.



## License

PersianDatePicker is available under the MIT license. See the LICENSE file for more information.


