//
//  Model.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 04.06.2022.
//

import Foundation
import UIKit
import AVKit
import AVFoundation


var numberOfSound = 0

//MARK: - variables

//создадим два массива которые будут овечать за навигацию по трекам и по обложкам треков
var soundTracksArray: [String] = ["bazaru-net", "kopy", "puding", "velik"]
var imagesArray: [String] = ["Image1","Image2","Image3","Image4"]

//количество треков в альбоме
let numbersOfTracks = soundTracksArray.count

//MARK: - methods

//ФУНКЦИИ СОЗДАНИЯ ОСНОВНЫХ ЭЛЕМЕНТОВ

//АНИМАЦИЯ НАЖАТИЯ КНОПКИ
func animateView (_ viewToAnimate : UIView) {
    UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 20, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
        viewToAnimate.transform = CGAffineTransform (scaleX: 0.95, y: 0.95)
        
    }) { (_) in
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform (scaleX: 1, y: 1)
            
        }, completion: nil)
        
    }
}
//Функция перехода на Плейер ВЬюконтроллер
func goEnterVC (vC: UIViewController) {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    guard let nextScreen = mainStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else {return}
    nextScreen.modalPresentationStyle = .fullScreen
    vC.show(nextScreen, sender: nil)
}


//MARK: - методы создания частей альбома

//функция созлает прозрачную клавишу которая закрывает все элементы (для перехода на след экран)
func createButton (newButton: UIButton, xMain: CGFloat, yMain: CGFloat, vC: UIViewController, select: Selector) {
    newButton.frame = CGRect (x: xMain, y: yMain, width: 330, height: 110)
    newButton.backgroundColor = .clear
    newButton.layer.cornerRadius = 15
    vC.view.addSubview(newButton)
    newButton.addTarget(vC, action: select, for: .touchUpInside)
}

//функция создает подложку для трека
func createBackground (xMain: CGFloat, yMain: CGFloat, vC: UIViewController, numberOfSound: Int) {
    let backLable = UILabel ()
    backLable.frame = CGRect (x: xMain - 10, y: yMain - 10, width: 330, height: 110)
    backLable.backgroundColor = UIImage(named: imagesArray[numberOfSound])?.averageColor
    backLable.alpha = 0.1
    backLable.layer.masksToBounds = true
    backLable.layer.cornerRadius = 20
    vC.view.addSubview(backLable)
}

// функция создает и отображает картинку беря ее из массива картонок
func createImageView (xMain: CGFloat, yMain: CGFloat, vC: UIViewController, numberOfImage: Int) {
    let imageView = UIImageView ()
    imageView.frame = CGRect(x: xMain, y: yMain, width: 90, height: 90)
    imageView.layer.cornerRadius = 15
    imageView.backgroundColor = .red
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    let imageSound = UIImage(named: imagesArray[numberOfImage])
    imageView.image = imageSound
    vC.view.addSubview(imageView)
}


//фуекция осздает лейбл с названием песни

func createNameLable (xMain: CGFloat, yMain: CGFloat, vC: UIViewController, numberOfSound: Int) {
    let nameLable = UILabel ()
    nameLable.frame = CGRect (x: xMain + 100, y: yMain + 15, width: 200, height: 50)
    nameLable.text = "" + soundTracksArray[numberOfSound]
    nameLable.font = UIFont (name: "HelveticaNeue-Thin", size: 40)
    nameLable.textColor = .black
    nameLable.textAlignment = .left
    nameLable.numberOfLines = 0
    vC.view.addSubview(nameLable)
}

//функция создает лейбл с продолжительностью трека
func createTimeSound (xMain: CGFloat, yMain: CGFloat, vC: UIViewController, numberOfSound: Int) {
    let timeSeconds = CMTimeGetSeconds(AVAsset(url: URL(fileURLWithPath: (Bundle.main.path(forResource: soundTracksArray[numberOfSound], ofType: "mp3"))!)).duration)
    let timeSoundLabel = UILabel()
    timeSoundLabel.frame = CGRect(x: xMain + 270, y: yMain + 65 , width: 200, height: 40)
    timeSoundLabel.text = "\(Int(timeSeconds/60)):\(Int(timeSeconds)%60)"
    timeSoundLabel.font = UIFont (name: "PingFangTC-Thin", size: 15)
    timeSoundLabel.textColor = .systemGray
    timeSoundLabel.textAlignment = .left
    timeSoundLabel.numberOfLines = 0
    vC.view.addSubview(timeSoundLabel)
    
    
    
}

//расширение ЮАЙИмейдж с добавлением функции которая определяет и возвращает среднее значение цвета
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
