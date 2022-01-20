//
//  ViewController.swift
//  Order Drinks App
//
//  Created by Judy chen on 2022/1/9.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate { 

    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sugarSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var iceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sugarSlider: UISlider!
    @IBOutlet weak var iceSlider: UISlider!
    
    @IBOutlet weak var addSugarButton: UIButton!
    @IBOutlet weak var lessSugarButton: UIButton!
    @IBOutlet weak var addIceButton: UIButton!
    @IBOutlet weak var lessIceButton: UIButton!
    
    @IBOutlet weak var sugarView: UIView!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    @IBOutlet weak var iceView: UIView!
    @IBOutlet weak var selectedItemTextField: UITextField!
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
 
    
    @IBOutlet weak var confirmButton: UIButton!
    

    var size = ["小杯・","中杯・","大杯・"]
    var sizeIndex: Int?
    
    var sugar = ["無糖","加糖"]
    var sugarIndex: Int?
    var sugarDetails = ["","(微糖)","(半糖)","(少糖)","(全糖)"]
    var sDIndex: Int?
    
    var ice = ["・冰","・溫","・熱"]
    var iceIndex: Int?
    var iceDetails = ["(完全去冰) ","(去冰) ","(微冰) ","(少冰) ","(正常冰) "]
    var iDIndex: Int?

    var sugarValue = 0.25
    var iceValue = 0.5
    
    
    
    var icePrimaryColor = UIColor(red: 105/255, green: 152/255, blue: 171/255, alpha: 1)
    var iceSecondaryColor = UIColor(red: 64/255, green: 104/255, blue: 130/255, alpha: 1)
    var iceTertiaryColor = UIColor(red: 26/255, green: 55/255, blue: 77/255, alpha: 1)
    var iceFourthColor = UIColor(red: 177/255, green: 208/255, blue: 224/255, alpha: 1)
    var iceFifthColor = UIColor(red: 232/255, green: 240/255, blue: 242/255, alpha: 1)
    var sugarPrimaryColor = UIColor(red: 134/255, green: 72/255, blue: 121/255, alpha: 1)
    var sugarSecondaryColor = UIColor(red: 90/255, green: 51/255, blue: 81/255, alpha: 1)
    var sugarTertiaryColor = UIColor(red: 70/255, green: 29/255, blue: 54/255, alpha: 1)
    var sugarFourthColor = UIColor(red: 233/255, green: 166/255, blue: 166/255, alpha: 1)
    var sugarFifthColor = UIColor(red: 255/255, green: 239/255, blue: 239/255, alpha: 1)
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        iceSlider.isEnabled = false
        sugarSlider.isEnabled = false
        sugarHidden(change: true)
        iceHidden(change: true)
        
        updateIceViewSize()
        updateSugarViewSize()
        updateTextFieldBorder()
        
        updateAll()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
       return true
    }
    
    func updateAll(){
        iceValue = 0.5
        sugarValue = 0.25
        confirmedContent = ""
        memoTextField.text = ""
        selectedItemTextField.text = ""
        contentLabel.text = ""
        num = 1
        
    }

    func updateTextFieldBorder(){
        selectedItemTextField.layer.borderColor = UIColor(red: 236/255, green: 219/255, blue: 186/255, alpha: 1).cgColor
        selectedItemTextField.layer.borderWidth = 3
    }
    
    func updateIceViewSize(){
        iceLabel.sizeToFit()
        iceView.frame.size = iceLabel.frame.size
  
        
    }
    func updateSugarViewSize(){
        sugarLabel.sizeToFit()
        sugarView.frame.size = sugarLabel.frame.size

    }
    
    func sugarHidden(change: Bool){
        sugarSlider.isHidden = change
        addSugarButton.isHidden = change
        lessSugarButton.isHidden = change
        sugarLabel.isHidden = change
        sugarView.isHidden = change
    }
    
    func iceHidden(change: Bool){
        iceSlider.isHidden = change
        addIceButton.isHidden = change
        lessIceButton.isHidden = change
        iceLabel.isHidden = change
        iceView.isHidden = change
    }
    
    func setIceSliderDetails(text: String, minTrackTintColor: UIColor ,thumbTintColor : UIColor){
        iceLabel.text = text
        iceSlider.minimumTrackTintColor = minTrackTintColor
        iceSlider.thumbTintColor = thumbTintColor
        updateIceViewSize()
    }
    func setSugarSliderDetails(text: String, minTrackTintColor: UIColor ,thumbTintColor : UIColor){
        sugarLabel.text = text
        sugarSlider.minimumTrackTintColor = minTrackTintColor
        sugarSlider.thumbTintColor = thumbTintColor
        updateSugarViewSize()
    }
    
    
    
    /*
     【自訂function區】
     1. 讓甜度Label文字隨slider值切換
     2. 讓冰塊Label文字隨slider值切換
     */
    func sugarLabelchange(){
        if sugarSlider.value == 0{
            setSugarSliderDetails(text: " 無糖 ", minTrackTintColor: sugarFifthColor, thumbTintColor: sugarFifthColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugarS0-size",content)
            }
            sugarIndex = 0
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugarS0-sugar",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("sugarS0-ice",content)
            }
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugarS0-iceD",content)
                }
            }
            selectedItemTextField.text = content
            
        }else if sugarSlider.value == 0.25{
            setSugarSliderDetails(text: " 微糖 ", minTrackTintColor: sugarFourthColor, thumbTintColor: sugarFourthColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugarS0.25-size",content)
            }
            sugarIndex = 1
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugarS0-sugar",content)
            }
            sDIndex = 1
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("sugarS0.25-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("sugarS0.25-ice",content)
            }

            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugarS0.25-iceD",content)
                }
            }
            selectedItemTextField.text = content
         
        }else if sugarSlider.value == 0.5{
            setSugarSliderDetails(text: " 半糖 ", minTrackTintColor: sugarPrimaryColor, thumbTintColor: sugarPrimaryColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugarS0-size",content)
            }
            sugarIndex = 1
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugarS0-sugar",content)
            }
            sDIndex = 2
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("sugarS0.5-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("sugarS0-ice",content)
            }

            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugarS0.5-iceD",content)
                }
            }
            selectedItemTextField.text = content
            
        }else if sugarSlider.value == 0.75{
            setSugarSliderDetails(text: " 少糖 ", minTrackTintColor: sugarSecondaryColor, thumbTintColor: sugarSecondaryColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugarS0-size",content)
            }
            sugarIndex = 1
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugarS0-sugar",content)
            }
            sDIndex = 3
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("sugarS0.75-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("sugarS0.75-ice",content)
            }

            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugarS0.75-iceD",content)
                }
            }
            selectedItemTextField.text = content
            
        }else {
            setSugarSliderDetails(text: " 全糖 ", minTrackTintColor: sugarTertiaryColor, thumbTintColor: sugarTertiaryColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugarS0-size",content)
            }
            sugarIndex = 1
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugarS0-sugar",content)
            }
            sDIndex = 4
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("sugarS1-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("sugarS1-ice",content)
            }
 
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugarS0-iceD",content)
                }
            }
            selectedItemTextField.text = content

        }
        
    }
    
    
    
    func iceLabelChange(){
        if iceSlider.value == 0{
            iceLabel.text = " 完全去冰 "
            iceSlider.thumbTintColor = iceFifthColor
            updateIceViewSize()
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("iceS0-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("iceS0-sugar",content)
            }
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("iceS0-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("iceS0-ice",content)
            }
            iDIndex = 0
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("iceS0-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else if iceSlider.value == 0.2{
            setIceSliderDetails(text: " 去冰 ", minTrackTintColor: iceFourthColor, thumbTintColor: iceFourthColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("iceS0.2-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("iceS0.2-sugar",content)
            }
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("iceS0.2-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("iceS0.2-ice",content)
            }
            iDIndex = 1
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("iceS0.2-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else if iceSlider.value == 0.5{
            setIceSliderDetails(text: " 微冰 ", minTrackTintColor: icePrimaryColor, thumbTintColor: icePrimaryColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("iceS0.5-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("iceS0.5-sugar",content)
            }
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("iceS0.5-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("iceS0.5-ice",content)
            }
            iDIndex = 2
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("iceS0.5-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else if iceSlider.value == 0.8{
            setIceSliderDetails(text: " 少冰 ", minTrackTintColor: iceSecondaryColor, thumbTintColor: iceSecondaryColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("iceS0.8-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("iceS0.8-sugar",content)
            }
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("iceS0.8-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("iceS0.8-ice",content)
            }
            iDIndex = 3
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("iceS0.8-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else {
            setIceSliderDetails(text: " 正常冰 ", minTrackTintColor: iceTertiaryColor, thumbTintColor: iceTertiaryColor)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("iceS1-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("iceS1-sugar",content)
            }
            if sDIndex != nil{
                content = content + sugarDetails[sDIndex!]
                print("iceS1-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("iceS1-ice",content)
            }
            iDIndex = 4
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("iceS1-iceD",content)
                }
            }
            selectedItemTextField.text = content
          
        }
    }
    
    
    
    
    /*
     1.
     */
    @IBAction func sizeSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            var content = ""
            sizeIndex = 0
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("size0-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("size0-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("size0-sugarD",content)
            }
            
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("size0-iceD",content)
                
            }
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("size0-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else if sender.selectedSegmentIndex == 1{
            var content = ""
            sizeIndex = 1
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("size1-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("size1-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("size1-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("size1-ice",content)
            }
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("size1-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else if sender.selectedSegmentIndex == 2{
            var content = ""
            sizeIndex = 2
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("size2-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("size2-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("size2-sugarD",content)
            }
            if iceIndex != nil{
                
                content = content + ice[iceIndex!]
                print("size2-iceD",content)
            }
            if iDIndex != nil{
             if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("size2-iceD",content)
            }
            }
            selectedItemTextField.text = content
        }
    }
    
    @IBAction func sugarSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            sugarHidden(change: false)
            sugarValue = 0
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugar0-size",content)
            }
            sugarIndex = 0
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugar0-sugar",content)
            }
            sDIndex = 0
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("sugar0-sugarD",content)
            }
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("sugar0-ice",content)
            }
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugar0-iceD",content)
                }
            }
            selectedItemTextField.text = content
        }else if sender.selectedSegmentIndex == 1{
            sugarHidden(change: false)
            sugarValue = 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("sugar1-size",content)
            }
            sugarIndex = 1
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("sugar1-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("sugar1-sugarD",content)
            }
            if iceIndex != nil{
                
                content = content + ice[iceIndex!]
                print("sugar1-ice",content)
            }
            if iDIndex != nil{
                if iceSegmentedControl.selectedSegmentIndex == 0{
                content = content + iceDetails[iDIndex!]
                print("sugar1-iceD",content)
                }
            }
            selectedItemTextField.text = content
            }
        }
    
    
    
    @IBAction func iceSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            iceHidden(change: false)
            iceValue = 0.5
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("ice0-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("ice0-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("ice0-sugarD",content)
            }
            iceIndex = 0
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("ice0-ice",content)
            }
            iDIndex = 2
            if iDIndex != nil{
                content = content + iceDetails[iDIndex!]
                print("ice0-iceD",content)
            }
            selectedItemTextField.text = content
            
        }else if sender.selectedSegmentIndex == 1{
            iceHidden(change: true)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("ice1-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("ice1-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("ice1-sugarD",content)
            }
            iceIndex = 1
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("ice1-ice",content)
            }
            selectedItemTextField.text = content
        }else if sender.selectedSegmentIndex == 2{
            iceHidden(change: true)
            var content = ""
            if sizeIndex != nil{
                content = content + size[sizeIndex!]
                print("ice2-size",content)
            }
            if sugarIndex != nil{
                content += sugar[sugarIndex!]
                print("ice2-sugar",content)
            }
            if sDIndex != nil{
                content += sugarDetails[sDIndex!]
                print("ice2-sugarD",content)
            }
            iceIndex = 2
            if iceIndex != nil{
                content = content + ice[iceIndex!]
                print("ice2-ice",content)
            }
            selectedItemTextField.text = content
            
        }
    
        }
    
    @IBAction func addSugar(_ sender: UIButton){
        if sugarValue == 0{
            sugarValue = sugarValue + 0.25
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print("A",sugarValue)

        }else if sugarValue < 0.75{
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarValue = sugarValue + 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print("B",sugarValue)
        }else{
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarValue = 1
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print("c",sugarValue)
            
        }
    }
    
        
    @IBAction func lessSugar(_ sender: UIButton) {
        if sugarValue > 0{
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarValue = sugarValue - 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print(sugarValue)
            if sugarValue == 0{
                sugarSlider.value = Float(sugarValue)
                sugarSegmentedControl.selectedSegmentIndex = 0
            }
        }else if sugarValue < 0.25{
            sugarValue = 0
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print(sugarValue)
        }
        
    }
    
    @IBAction func addIce(_ sender: UIButton) {
        if iceValue == 0 {
            iceValue = iceValue + 0.2
            iceSlider.value = Float(iceValue)
            print(iceValue)
            iceLabelChange()
        }else if iceValue < 0.8{
            iceValue = iceValue + 0.3
            iceSlider.value = Float(iceValue)
            print(iceValue)
            iceLabelChange()
            
        }else{
            iceValue = 1
            iceSlider.value = Float(iceValue)
            print(iceValue)
            iceLabelChange()
        }
    }
    
    @IBAction func lessIce(_ sender: UIButton) {
        if iceValue == 1 {
            iceValue = iceValue - 0.2
            iceSlider.value = Float(iceValue)
            print(iceValue)
            iceLabelChange()
        }else if iceValue > 0.2 {
            iceValue = iceValue - 0.3
            iceSlider.value = Float(iceValue)
            print(iceSlider.value)
            iceLabelChange()
        }else if iceValue > 0{
            iceValue = 0
            iceSlider.value = Float(iceValue)
            print(iceValue)
            iceLabelChange()
            
            
        }
    }
    
    
    
    //讓甜度和冰塊的值不能透過slider的thumb調整
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        iceSlider.isEnabled = false
        sugarSlider.isEnabled = false
    }
    

    
 
    @IBAction func reset(_ sender: Any) {
        updateAll()
    }
    
    

    
    
    
    
    var confirmedContent = ""
    var num = 1
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
            
            confirmedContent.append("\(num). ")
            confirmedContent.append(selectedItemTextField.text!)
            confirmedContent.append("\t")
            confirmedContent.append(memoTextField.text!)
            confirmedContent.append("\n")
            contentLabel.text = confirmedContent
            selectedItemTextField.text = ""
            memoTextField.text = ""
            num = num + 1
            


        
    
        print("sugar: \(sugarValue),ice: \(iceValue)")
        
        
    }
    
   
    
    

}

