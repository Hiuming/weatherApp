//
//  File.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 23/09/2021.
//
import SpriteKit

class  SpriteAnimation: SKScene{
    private var effectName : String?
    
  
 override func sceneDidLoad() {
       
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        let node = SKEmitterNode(fileNamed: effectName!)!
        
        addChild(node)
        
        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
    init(effectName :String) {
        super.init()
        self.effectName = effectName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
