## PersianDatePicker

 PersianDatePicker written in Swift

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

### Use

you should import PersianDatePicker in your View

```swift
import PersianDatePicker
```

### StoryBoard
you can use in the storyboard, you add a UIView in your ViewController and inherit from [ PersianDatePickerView ]

<img src="https://github.com/farhad1985/PersianDatePicker/blob/master/ScreenShot/Screen%20Shot%202017-05-08%20at%201.30.16%20PM.png" height="202" width="442" />

### Style
you can use pickerStyle for two types . 

<img src="https://raw.githubusercontent.com/farhad1985/PersianDatePicker/master/ScreenShot/Simulator%20Screen%20Shot%20Jul%2029%2C%202017%2C%2011.17.23%20AM.png" height="202" width="442" />


### Delegates

then you should implement PersianDateDelegate like this :

```swift
extension ViewController: PersianDateDelegate {
    
    func persianDate(persianDatePickerView: PersianDatePickerView, year: Int, month: Int, day: Int) {
        label.text = "\(year)/\(month)/\(day)"
    }
}

```

if you need to show name's month, you have to impl this :

```swift
extension ViewController: PersianDateDelegate {
    
    func persianDate(persianDatePickerView: PersianDatePickerView, year: Int, monthName: String, day: Int) {
        label1.text = "\(day) - \(monthName) - \(year)"

    }
}

```

## License

PersianDatePicker is released under the GPL2 license. 

