//
//  ViewController.swift
//  TagStyledView
//
//  Created by dave.pang on 11/08/2018.
//  Copyright (c) 2018 dave.pang. All rights reserved.
//

import UIKit
import TagStyledView

extension ViewController {
    struct Default {
        struct Inset {
            static let top = 5.0
            static let left = 5.0
            static let bottom = 5.0
            static let right = 5.0
        }

        static let tagStyle = 0
        static let align = 1

        static let lineSpacing = 10.0
        static let interitemSpacing = 10.0

        static let tags = ["first", "second", "third", "fourth fourth fourth fourth fourth fourth fourth", "fifth"]
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tagStyledView: TagStyledView!
    @IBOutlet weak var insetTop: StepperOptionView!
    @IBOutlet weak var insetLeft: StepperOptionView!
    @IBOutlet weak var insetBottom: StepperOptionView!
    @IBOutlet weak var insetRight: StepperOptionView!
    @IBOutlet weak var lineSpacing: StepperOptionView!
    @IBOutlet weak var interitemSpacing: StepperOptionView!
    @IBOutlet weak var styleSegControl: UISegmentedControl!
    @IBOutlet weak var alignControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reset()
    }

    private func reset() {
        tagStyledView.tags = Default.tags
        defaultSetup()
        display()
        changeOptions()
    }
    
    private func defaultSetup() {
        tagStyledView.register(UINib(nibName: TagCell1.Resource.identifier, bundle: nil), forCellWithReuseIdentifier: TagCell1.Resource.identifier)
        
        insetTop.stepper.value = Default.Inset.top
        insetLeft.stepper.value = Default.Inset.left
        insetBottom.stepper.value = Default.Inset.bottom
        insetRight.stepper.value = Default.Inset.right
        
        interitemSpacing.stepper.value = Default.interitemSpacing
        lineSpacing.stepper.value = Default.lineSpacing
        
        styleSegControl.selectedSegmentIndex = Default.tagStyle
        alignControl.selectedSegmentIndex = Default.align
    }
    
    private func changeOptions() {
        switch styleSegControl.selectedSegmentIndex {
        case 0:
            tagStyledView.register(UINib(nibName: TagCell1.Resource.identifier, bundle: nil), forCellWithReuseIdentifier: TagCell1.Resource.identifier)
        case 1:
            tagStyledView.register(UINib(nibName: TagCell2.Resource.identifier, bundle: nil), forCellWithReuseIdentifier: TagCell2.Resource.identifier)
        case 2:
            tagStyledView.register(UINib(nibName: TagCell3.Resource.identifier, bundle: nil), forCellWithReuseIdentifier: TagCell3.Resource.identifier)
        default:
            break
        }
  
        let align: (() -> TagStyledView.Options.Alignment) = { [unowned self] in
            switch self.alignControl.selectedSegmentIndex {
            case 1:  return TagStyledView.Options.Alignment.left
            case 2:  return TagStyledView.Options.Alignment.center
            case 3:  return TagStyledView.Options.Alignment.right
            default: return TagStyledView.Options.Alignment.justified
            }
        }
        
        tagStyledView.options = TagStyledView.Options(sectionInset: UIEdgeInsets(top: CGFloat(insetTop.stepper.value),
                                                                                left: CGFloat(insetLeft.stepper.value),
                                                                                bottom: CGFloat(insetBottom.stepper.value),
                                                                                right: CGFloat(insetRight.stepper.value)),
                                                     lineSpacing: CGFloat(lineSpacing.stepper.value),
                                                     interitemSpacing: CGFloat(interitemSpacing.stepper.value),
                                                     align: align())
    }
    
    private func display() {
        insetTop.label.text = "inset top: " + "\(Int(insetTop.stepper.value))"
        insetLeft.label.text = "inset left: " + "\(Int(insetLeft.stepper.value))"
        insetBottom.label.text = "inset bottom: " + "\(Int(insetBottom.stepper.value))"
        insetRight.label.text = "inset right: " + "\(Int(insetRight.stepper.value))"
        
        lineSpacing.label.text = "line spacing: " + "\(Int(lineSpacing.stepper.value))"
        interitemSpacing.label.text = "interitem spacing: " + "\(Int(interitemSpacing.stepper.value))"
    }
    
    @IBAction func insetAction(_ sender: Any) {
        display()
        changeOptions()
    }
    
    @IBAction func tagStyleAction(_ sender: Any) {
        changeOptions()
    }
    
    @IBAction func alignAction(_ sender: Any) {
        changeOptions()
    }
    
    @IBAction func reset(_ sender: Any) {
        reset()
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "Add Tag", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (field) in
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Append", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            if let field = alert.textFields?.first,
                let text = field.text {
                self.tagStyledView.tags = (self.tagStyledView.tags?.compactMap{ $0 } ?? []) + [text]
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
