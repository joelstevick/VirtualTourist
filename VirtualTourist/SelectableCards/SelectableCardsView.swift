//
//  SelectableCardsView.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/22/22.
//

import UIKit

class SelectableCardsView: UIView {
    
    // MARK: - Properties
    @IBOutlet weak var noPicturesLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let viewFromXib = Bundle.main.loadNibNamed("SelectableCardsView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
