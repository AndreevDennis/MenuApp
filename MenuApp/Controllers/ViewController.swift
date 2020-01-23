//
//  ViewController.swift
//  MenuApp
//
//  Created by Денис Андреев on 30.11.2019.
//  Copyright © 2019 Денис Андреев. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate{
    
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    var isJumping = false
    @IBOutlet weak var caloriesLbl: UILabel!
    
    var node1 = SCNNode()
    var imageNodes = [SCNNode]()
    let imageCon = ARImageTrackingConfiguration()
    
    
    
    override func viewDidLoad() {
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        var names = "art.scnassets/3.scn"
        
        switch rowNumber {
        case 0:
            print("Your number is 0")
            names = "art.scnassets/6.scn"
            weightLbl.text = "100"
            nameLbl.text = "Pelmeni"
            caloriesLbl.text = "200k"
        case 1:
            print("Your number is 1")
            names =  "art.scnassets/2.scn"
            weightLbl.text = "600"
            nameLbl.text = "Vareniki"
            caloriesLbl.text = "220k"
        case 2:
            print("Your number is 2")
            names =  "art.scnassets/4.scn"
            weightLbl.text = "500"
            nameLbl.text = "Borsch"
            caloriesLbl.text = "600k"
        case 3:
            print("Your number is 3")
            weightLbl.text = "400"
            names =  "art.scnassets/5.scn"
            nameLbl.text = "Vodka"
            caloriesLbl.text = "250k"
        case 4:
            print("Your number is 4")
            weightLbl.text = "300"
            names =  "art.scnassets/2.scn"
            nameLbl.text = "Tea"
            caloriesLbl.text = "400k"
        case 5:
            print("Your number is 5")
            weightLbl.text = "300"
            names =  "art.scnassets/1.scn"
            nameLbl.text = "Tea"
            caloriesLbl.text = "400k"
        default:
//            names = "art.scnassets/3.scn"
            print("ggr")
        }
        
        let scene = SCNScene(named: names)!
        
        
        node1 = scene.rootNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let trackingImages  = ARReferenceImage.referenceImages(inGroupNamed: "Images", bundle: Bundle.main) {
            imageCon.trackingImages = trackingImages
        }
        
        sceneView.session.run(imageCon)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let size = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.0)
            plane.cornerRadius = 0.005
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            var shapeNode: SCNNode?
            
            switch imageAnchor.referenceImage.name {
            case cardType.king.rawValue:
                shapeNode = node1
            default:
                break
            }
            
            guard let shape  = shapeNode else {return
                nil}
            node.addChildNode(shape)
            spinJump(node: node)
            imageNodes.append(node)
            return node
        }
        
        return nil
    }
    
    
    func spinJump(node:SCNNode){
        if isJumping {return}
        else {
            let shapeNode = node.childNodes[1]
            let shapeSpin = SCNAction.rotateBy(x: 0, y: 2 * .pi, z:0, duration: 1)
            shapeSpin.timingMode = .easeInEaseOut
            let up = SCNAction.moveBy(x: 0, y: 0.03, z: 0, duration: 0.5)
            up.timingMode = .easeInEaseOut
            let down = up.reversed()
            let upDown = SCNAction.sequence([up,down])
            
            
            shapeNode.runAction(shapeSpin)
            shapeNode.runAction(upDown)
        }
    }
    
    
}

enum cardType:String {
    case king = "carta1"
}
