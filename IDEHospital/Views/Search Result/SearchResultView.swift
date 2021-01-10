//
//  File.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/22/20.
//

import Foundation
import UIKit
class SearchResultView:UIView{
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var arrowImageInTextField: UIImageView!

    var pickerView = UIPickerView()
    //MARK:- Public Functions
    func setupView() {
        // setBackround
        self.setupBackground()
        // set FilterView Background Color
        sortView.backgroundColor = UIColor(named: ColorName.darkRoyalBlue)
        // set SortBy Label
        searchResultTableView.separatorStyle = .none
        self.setUpLabel(label: sortByLabel, labelText: L10n.sortBy, fontName: FontFamily.PTSans.bold, fontSize: 12, fontColor: .white, alpha: 1)
        // set Filter TextField
        self.setUpTextFiled(textFiled: filterTextField, textValue: L10n.rating, placeholder: "", imageName: Asset.whiteArrow.image, imageViewInTextFiled: arrowImageInTextField, fontName: FontFamily.PTSans.bold, fontSize: 12, tag: 1)
        
    }
}
extension SearchResultView{
    //MARK:- Private Functions
    
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor, alpha:CGFloat) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.textAlignment = .center
        label.text = labelText
        label.textColor = fontColor
        label.alpha = alpha
    }
    
    private func setUpTextFiled(textFiled:UITextField,textValue:String, placeholder:String, imageName:UIImage, imageViewInTextFiled:UIImageView, fontName:FontConvertible, fontSize:CGFloat, tag:Int) {
        
        if imageName == UIImage() {
            imageViewInTextFiled.image = UIImage()
        }
        else{
            imageViewInTextFiled.image = imageName
        }
        textFiled.backgroundColor = .clear
        textFiled.borderStyle = .none
        textFiled.text = textValue
        textFiled.font = UIFont(font: fontName, size: fontSize)
        textFiled.textColor = .white
        textFiled.tag = tag
        textFiled.inputView = pickerView
    }
}
