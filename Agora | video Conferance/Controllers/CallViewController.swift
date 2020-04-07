//
//  ViewController.swift
//  Agora | video Conferance
//
//  Created by Mohamed Ahmed on 4/6/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import UIKit
import AgoraRtcKit

class CallViewController: UIViewController {
    @IBOutlet weak var localVideo: UIView!
    @IBOutlet weak var remoteVideo: UIView!
    
    var agoraKit: AgoraRtcEngineKit!
    
    var appID = "27da0ffdd35d474882a96fc626d9cf54"
    var token = "00627da0ffdd35d474882a96fc626d9cf54IACuxdHS633tzMWqMx4YzJflIOsMhxdMSDTySHnLAXL2t0i54xYAAAAAEABm+tK2I+WMXgEAAQAj5Yxe"
    var channelID = "-2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAgoraEngine()
        setupVideo()
        setupLocalVideo()
        joinChannel()
    }
    
    
    func initializeAgoraEngine() {
        agoraKit =  .sharedEngine(withAppId: appID, delegate: self)
    }
    
    func setupVideo() {
        agoraKit.enableVideo()
    }
    
    func setupLocalVideo() {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localVideo
        videoCanvas.renderMode = .hidden
        agoraKit.setupLocalVideo(videoCanvas)
    }
    
    
    func joinChannel() {
        agoraKit.setDefaultAudioRouteToSpeakerphone(true)
        agoraKit.joinChannel(byToken: token , channelId: channelID , info:nil, uid:0) { (channel, uid, elapsed) -> Void in
            // actions
        }
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    @IBAction func muteIsPressed(_ sender: UIButton) {
        agoraKit.muteLocalAudioStream(sender.isSelected)
    }
    
    @IBAction func cancelIsPressed(_ sender: UIButton) {
        agoraKit.leaveChannel(nil)
        UIApplication.shared.isIdleTimerDisabled = false
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func swtichIsPressed(_ sender: UIButton) {
        agoraKit.switchCamera()
    }
}


extension CallViewController: AgoraRtcEngineDelegate {
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
        self.agoraKit.muteLocalAudioStream(false)
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = self.remoteVideo
        videoCanvas.renderMode = .fit
        self.agoraKit.setupRemoteVideo(videoCanvas)
    }
}
