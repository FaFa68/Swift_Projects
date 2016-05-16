//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var StringOptional: String? = "bob"

//Optionals
var  optionalString = Optional<String>.None
optionalString = Optional<String>.Some("Hello")

switch optionalString {
case .Some(let value): var optionalString2 = value
case .None: break
}

var stringValue : String? = nil
var displayValue = stringValue ?? " "



//Tuples
let x: (String , Int , Character) = ("Ali" , 3 , "M")
print(x.0)
print(x.1)
print(x.2)

let (Name , Age , Sex) = x
print(Name)
print(Age)
print(Sex)


let y: (Name: String , Age: Int , Sex: Character) = ("Jasem",9,"M")
print(y.Age)
print(y.Name)
print(y.Sex)

//Range
let array = ["a","b","c","d","e","f"]
let subArray1 = array[2...3]
let subArray2 = array[2..<3]

let arr = [2,3,4,5,6,7,8,9,10].filter({$0 > 5})
for number in arr {
    print(number)
}

//Methodes



let stringfied: [String] = [1,3,4,6,7].map({String($0)})
var StringOfarr = " "
for str in stringfied {
    StringOfarr.appendContentsOf(str)
}
print(StringOfarr)

let sum: Int = [1,2,3,4,5,6,7,8,9].reduce(0){$0+$1}

    print(sum)



var mathGrade = ["Ali": 20 ,
                 "faFa":19 ,
                 "kimdi":18,
                 "Jasem":17
]

for (key , value) in mathGrade {
    if value > 18 {
        print("Key: " + key)
    }
}




for (key , _ ) in mathGrade{
    if key.characters.count <= 4 {
        print(key.capitalizedString)
    }
}


