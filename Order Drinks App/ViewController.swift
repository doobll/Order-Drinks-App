//
//  ViewController.swift
//  Order Drinks App
//
//  Created by Judy chen on 2022/1/9.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sugarSementedControl: UISegmentedControl!
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
    
    @IBOutlet weak var contentLabel: UILabel!
 
    


    
    var drinkSize = ["小","中","大"]
    var sizeIndex = 2
    var sugar = ["無糖","加糖"]
    var sugarIndex = 1
    var ice = ["冰","溫","熱"]
    var iceIndex = 0
    var iceValue = 0.5
    var sugarValue = 0.25
    
    
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
        updateIceViewSize()
        updateSugarViewSize()
    }

    func updateIceViewSize(){
        iceLabel.sizeToFit()
        iceView.frame.size = iceLabel.frame.size
    }
    func updateSugarViewSize(){
        sugarLabel.sizeToFit()
        sugarView.frame.size = sugarLabel.frame.size
    }
    
    /*
     【自訂function區】
     1. 讓甜度Label文字隨slider值切換
     2. 讓冰塊Label文字隨slider值切換
     */
    func iceLabelChange(){
        if iceSlider.value == 0{
            iceLabel.text = " 完全去冰     "
            //iceLabel.numberOfLines = 2
           //iceLabel.font = UIFont(name: "System Light", size: 10)
            iceSlider.thumbTintColor = iceFifthColor
            //updateIceViewSize()
        }else if iceSlider.value == 0.2{
            iceLabel.text = " 去冰 "
            //iceLabel.numberOfLines = 1
            //iceLabel.font = UIFont(name: "System Light", size: 20)
            iceSlider.minimumTrackTintColor = iceFourthColor
            iceSlider.thumbTintColor = iceFourthColor
            updateIceViewSize()
        }else if iceSlider.value == 0.5{
            iceLabel.text = " 微冰 "
            //iceLabel.numberOfLines = 1
            //iceLabel.font = UIFont(name: "System Light", size: 20)
            iceSlider.minimumTrackTintColor = icePrimaryColor
            iceSlider.thumbTintColor = icePrimaryColor
            updateIceViewSize()
        }else if iceSlider.value == 0.8{
            iceLabel.text = " 少冰 "
            //iceLabel.numberOfLines = 1
            //iceLabel.font = UIFont(name: "System Light", size: 20)
            iceSlider.minimumTrackTintColor = iceSecondaryColor
            iceSlider.thumbTintColor = iceSecondaryColor
            updateIceViewSize()
        }else {
            iceLabel.text = " 正常冰 "
            //iceLabel.numberOfLines = 1
            //iceLabel.font = UIFont(name: "System Light", size: 20)
            iceSlider.minimumTrackTintColor = iceTertiaryColor
        iceSlider.thumbTintColor = iceTertiaryColor
            updateIceViewSize()
          
        }
    }
    
    func sugarLabelchange(){
        if sugarSlider.value == 0{
            sugarLabel.text = " 無糖 "
            sugarSlider.thumbTintColor = UIColor(red: 255/255, green: 239/255, blue: 239/255, alpha: 1)
            updateSugarViewSize()
        }else if sugarSlider.value == 0.25{
            sugarLabel.text = " 微糖 "
            sugarSlider.minimumTrackTintColor = UIColor(red: 233/255, green: 166/255, blue: 166/255, alpha: 1)
            sugarSlider.thumbTintColor = UIColor(red: 233/255, green: 166/255, blue: 166/255, alpha: 1)
            updateSugarViewSize()
        }else if sugarSlider.value == 0.5{
            sugarLabel.text = " 半糖 "
            sugarSlider.minimumTrackTintColor = UIColor(red: 134/255, green: 72/255, blue: 121/255, alpha: 1)
            sugarSlider.thumbTintColor = UIColor(red: 134/255, green: 72/255, blue: 121/255, alpha: 1)
            updateSugarViewSize()
        }else if sugarSlider.value == 0.75{
            sugarLabel.text = " 少糖 "
            sugarSlider.minimumTrackTintColor = UIColor(red: 90/255, green: 51/255, blue: 81/255, alpha: 1)
            sugarSlider.thumbTintColor = UIColor(red: 90/255, green: 51/255, blue: 81/255, alpha: 1)
            updateSugarViewSize()
        }else {
            sugarLabel.text = " 全糖 "
            sugarSlider.minimumTrackTintColor = UIColor(red: 70/255, green: 29/255, blue: 54/255, alpha: 1)
            sugarSlider.thumbTintColor = UIColor(red: 70/255, green: 29/255, blue: 54/255, alpha: 1)
            updateSugarViewSize()
        }
        
    }
    

    
    /*
     1.
     */
    @IBAction func sizeSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            sizeIndex = 0
            print(drinkSize[sizeIndex])
        }else if sender.selectedSegmentIndex == 1{
            sizeIndex = 1
            print(drinkSize[sizeIndex])
        }else{
            sizeIndex = 2
            print(drinkSize[sizeIndex])
        }
    }
    
    @IBAction func sugarSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            sugarIndex = 0
            sugarValue = 0
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
        }else if sender.selectedSegmentIndex == 1{
            sugarIndex = 1
            sugarValue = 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
        }
    }
    
    @IBAction func iceSegmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            iceSlider.isHidden = true
            addIceButton.isHidden = true
            lessIceButton.isHidden = true
        }else if sender.selectedSegmentIndex == 2{
            iceSlider.isHidden = true
            addIceButton.isHidden = true
            lessIceButton.isHidden = true
        }else{
            iceSlider.isHidden = false
            addIceButton.isHidden = false
            lessIceButton.isHidden = false
        }
    }
    
    
    @IBAction func addSugar(_ sender: UIButton) {
        if sugarValue < 1 {
            sugarSementedControl.selectedSegmentIndex = 1
            sugarValue = sugarValue + 0.25
            sugarSlider.value = Float(sugarValue)
            print(sugarValue)
                sugarSementedControl.selectedSegmentIndex = 1
            sugarLabelchange()
        }else if sugarValue > 0.75{
            sugarValue = 1.0
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print(sugarValue)
            
            }
        }
    
    @IBAction func lessSugar(_ sender: UIButton) {
        if sugarValue > 0{
            sugarSementedControl.selectedSegmentIndex = 1
            sugarValue = sugarValue - 0.25
            sugarSlider.value = Float(sugarValue)
            sugarLabelchange()
            print(sugarValue)
            if sugarValue == 0{
                sugarSlider.value = Float(sugarValue)
                sugarSementedControl.selectedSegmentIndex = 0
                sugarLabelchange()
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
    

    

   
    @IBAction func showSelectedItem(_ sender: UITextField) {
        if sizeSegmentedControl.isSelected{
            sender.text = drinkSize[sizeIndex] + sugar[sugarIndex]
        }
    }
    

    
    
    @IBAction func comfirmButtonPressed(_ sender: Any) {
        print("\(sugarValue)\(iceValue)")
    }
    
    

}

