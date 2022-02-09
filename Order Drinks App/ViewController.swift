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
    @IBOutlet weak var sugarSlider: UISlider!
    @IBOutlet weak var addSugarButton: UIButton!
    @IBOutlet weak var lessSugarButton: UIButton!
    @IBOutlet weak var sugarView: UIView!
    @IBOutlet weak var sugarLabel: UILabel!
    
    @IBOutlet weak var iceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var iceSlider: UISlider!
    @IBOutlet weak var addIceButton: UIButton!
    @IBOutlet weak var lessIceButton: UIButton!
    
    @IBOutlet weak var iceView: UIView!
    @IBOutlet weak var iceLabel: UILabel!
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var selectedItemTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
 
    
    
    

    var size = ["小杯・","中杯・","大杯・"]
    var sizeIndex: Int?
    
    var sugar = ["無糖","加糖"]
    var sugarIndex: Int?
    var sugarDetails = ["","(微糖)","(半糖)","(少糖)","(全糖)"]
    var sDIndex: Int?
    
    var ice = ["・冰","・溫","・熱"]
    var iceIndex: Int?
    var iceDetails = ["(完全去冰)","(去冰)","(微冰)","(少冰)","(正常冰)"]
    var iDIndex: Int?

    var sugarValue = 0.25
    var iceValue = 0.5
    
    
    //甜度相關元件屬性顏色
    var sugarPrimaryColor = UIColor(red: 134/255, green: 72/255, blue: 121/255, alpha: 1)
    var sugarSecondaryColor = UIColor(red: 90/255, green: 51/255, blue: 81/255, alpha: 1)
    var sugarTertiaryColor = UIColor(red: 70/255, green: 29/255, blue: 54/255, alpha: 1)
    var sugarFourthColor = UIColor(red: 233/255, green: 166/255, blue: 166/255, alpha: 1)
    var sugarFifthColor = UIColor(red: 255/255, green: 239/255, blue: 239/255, alpha: 1)
    //冰快關元件屬性顏色
    var icePrimaryColor = UIColor(red: 105/255, green: 152/255, blue: 171/255, alpha: 1)
    var iceSecondaryColor = UIColor(red: 64/255, green: 104/255, blue: 130/255, alpha: 1)
    var iceTertiaryColor = UIColor(red: 26/255, green: 55/255, blue: 77/255, alpha: 1)
    var iceFourthColor = UIColor(red: 177/255, green: 208/255, blue: 224/255, alpha: 1)
    var iceFifthColor = UIColor(red: 232/255, green: 240/255, blue: 242/255, alpha: 1)
    
    
    
    
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
    
    // 點空白處收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    // 點return鍵收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
       return true
    }
    
    
    /*
    【設定初始值】
      甜度：微糖 0.25
      冰塊：微冰 0.5
      設定備註欄位的提示文字
      清空已確認訂單資料（設為空字串）
      清空Label顯示的已確認訂單 （設為空字串）
      條列清單的數字重新回到1
     */
    func updateAll(){
        sugarValue = 0.25
        iceValue = 0.5
        memoTextField.placeholder = "備註：加料、是否要吸管"
        selectedItemTextField.placeholder = "可手動修改訂單內容"
        confirmedContent = ""
        contentLabel.text = ""
        num = 1
        
    }
    
    //設定待確認
    func updateTextFieldBorder(){
        selectedItemTextField.layer.borderColor = UIColor(red: 236/255, green: 219/255, blue: 186/255, alpha: 1).cgColor
        selectedItemTextField.layer.borderWidth = 3
    }

    //讓甜度label大小與文字範圍等寬後，甜度view尺寸與label尺寸等寬
    func updateSugarViewSize(){
        sugarLabel.sizeToFit()
        sugarView.frame.size = sugarLabel.frame.size
    }
    
    //讓冰塊label大小與文字範圍等寬後，冰塊view尺寸與label尺寸等寬
    func updateIceViewSize(){
        iceLabel.sizeToFit()
        iceView.frame.size = iceLabel.frame.size
    }
    
    //自訂一個func作為之後彈性隱藏甜度相關元件用
    func sugarHidden(change: Bool){
        sugarSlider.isHidden = change
        addSugarButton.isHidden = change
        lessSugarButton.isHidden = change
        sugarLabel.isHidden = change
        sugarView.isHidden = change
    }
    
    //自訂func作為之後彈性隱藏冰塊相關元件用
    func iceHidden(change: Bool){
        iceSlider.isHidden = change
        addIceButton.isHidden = change
        lessIceButton.isHidden = change
        iceLabel.isHidden = change
        iceView.isHidden = change
    }
    
    /*
     自訂func設定甜度slder的文字、滑軌最大最小值顏色、控制鈕顏色，
     同時呼叫前面updateIceViewSize讓view尺寸隨label大小改變
    */
    func setSugarSliderDetails(text: String, minTrackTintColor: UIColor ,thumbTintColor : UIColor){
        sugarLabel.text = text
        sugarSlider.minimumTrackTintColor = minTrackTintColor
        sugarSlider.thumbTintColor = thumbTintColor
        updateSugarViewSize()
    }
    
    /*
     自訂func設定冰塊slder的文字、滑軌最大最小值顏色、控制鈕顏色，
     同時呼叫前面updateIceViewSize讓view尺寸隨label大小改變
    */
    func setIceSliderDetails(text: String, minTrackTintColor: UIColor ,thumbTintColor : UIColor){
        iceLabel.text = text
        iceSlider.minimumTrackTintColor = minTrackTintColor
        iceSlider.thumbTintColor = thumbTintColor
        updateIceViewSize()
    }
   
    /*
     自訂func控制使用者點選甜度冰塊相關屬性時，將待確認訂單記錄在contents裡。屬性分別是飲料的份量、甜度有無＆甜度細節、冰溫熱＆冰塊細節
    */
    
    func setIndex(){
        var content = ""
        if sizeIndex != nil{
            content = content + size[sizeIndex!]
            print("sizeIndex",content)
        }
        if sugarIndex != nil{
            content += sugar[sugarIndex!]
            print("sugarIndex",content)
        }
        if sDIndex != nil{
            if sugarSegmentedControl.selectedSegmentIndex != 0{
            content = content + sugarDetails[sDIndex!]
                print("sugarDetailIndex",content)
            }
            
        }
        if iceIndex != nil{
            content = content + ice[iceIndex!]
            print("iceIndex",content)
        }
        if iDIndex != nil{
            if iceSegmentedControl.selectedSegmentIndex == 0{
            content = content + iceDetails[iDIndex!]
                print("iceDetailIndex",content)
            }
        }
        selectedItemTextField.text = content
    }
    
    
    
    /*
    slider按鈕只能點選出五個數值，label顯示對應的五種甜度
    無糖(0)、微糖(0.25)、半糖(0.5)、少糖(0.75)、全糖(1),textField顯示對應內容
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
            sugarIndex = 1
            sDIndex = 1
            setIndex()
        }else if sugarSlider.value == 0.5{
            setSugarSliderDetails(text: " 半糖 ", minTrackTintColor: sugarPrimaryColor, thumbTintColor: sugarPrimaryColor)
            sugarIndex = 1
            sDIndex = 2
            setIndex()
        }else if sugarSlider.value == 0.75{
            setSugarSliderDetails(text: " 少糖 ", minTrackTintColor: sugarSecondaryColor, thumbTintColor: sugarSecondaryColor)
            sugarIndex = 1
            sDIndex = 3
            setIndex()
        }else {
            setSugarSliderDetails(text: " 全糖 ", minTrackTintColor: sugarTertiaryColor, thumbTintColor: sugarTertiaryColor)
            sugarIndex = 1
            sDIndex = 4
            setIndex()

        }
        
    }
    
    
    /*
    slider按鈕只能點選出五個數值，label顯示對應的五種冰度
    完全去冰(0)、去冰(0.2)、微冰(0.5)、少冰(0.8)、正常冰(1),textField顯示對應內容
     */
    func iceLabelChange(){
        if iceSlider.value == 0{
            setIceSliderDetails(text: " 完全去冰 ", minTrackTintColor: iceFifthColor, thumbTintColor: iceFifthColor)
            iDIndex = 0
            setIndex()
        }else if iceSlider.value == 0.2{
            setIceSliderDetails(text: " 去冰 ", minTrackTintColor: iceFourthColor, thumbTintColor: iceFourthColor)
            iDIndex = 1
            setIndex()
        }else if iceSlider.value == 0.5{
            setIceSliderDetails(text: " 微冰 ", minTrackTintColor: icePrimaryColor, thumbTintColor: icePrimaryColor)
            iDIndex = 2
            setIndex()
        }else if iceSlider.value == 0.8{
            setIceSliderDetails(text: " 少冰 ", minTrackTintColor: iceSecondaryColor, thumbTintColor: iceSecondaryColor)
            iDIndex = 3
            setIndex()
        }else {
            setIceSliderDetails(text: " 正常冰 ", minTrackTintColor: iceTertiaryColor, thumbTintColor: iceTertiaryColor)
            iDIndex = 4
            setIndex()
        }
    }
    
    
    @IBAction func sizeSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            sizeIndex = 0
            setIndex()
        }else if sender.selectedSegmentIndex == 1{
            sizeIndex = 1
            setIndex()
        }else if sender.selectedSegmentIndex == 2{
            sizeIndex = 2
            setIndex()
        }
    }
    
    @IBAction func sugarSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            sugarHidden(change: false)
            sugarValue = 0
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            sugarIndex = 0
            sDIndex = 0
            setIndex()
        }else if sender.selectedSegmentIndex == 1{
            sugarHidden(change: false)
            sugarValue = 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            sugarIndex = 1
            setIndex()
            }
        }
    
    
    
    @IBAction func iceSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            iceHidden(change: false)
            iceValue = 0.5
            iceSlider.value = Float(iceValue)
            iceLabelChange()
            iceIndex = 0
            iDIndex = 2
            setIndex()
        }else if sender.selectedSegmentIndex == 1{
            iceHidden(change: true)
            iceSlider.value = Float(iceValue)
            iceLabelChange()
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
            iceSlider.value = Float(iceValue)
            iceLabelChange()
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
    
    //設定slider的value
    @IBAction func addSugar(_ sender: UIButton){
        if sugarValue == 0{
            sugarValue = sugarValue + 0.25
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()

        }else if sugarValue < 0.75{
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarValue = sugarValue + 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
        }else{
            sugarSegmentedControl.selectedSegmentIndex = 1
            sugarValue = 1
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            
        }
    }
    
    //設定slider的value
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

