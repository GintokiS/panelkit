//
//  PanelManager+Pinning.swift
//  PanelKit
//
//  Created by Louis D'hauwe on 07/03/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import UIKit

extension PanelManager {
	
	var panelPinnedLeft: PanelViewController? {
		return panels.filter { $0.pinnedSide == .left }.first
	}
	
	var panelPinnedRight: PanelViewController? {
		return panels.filter { $0.pinnedSide == .right }.first
	}
	
	var panelGrowDuration: Double {
		return 0.3
	}
	
	func pinnedPanelFrame(for panel: PanelViewController, at side: PanelPinSide) -> CGRect? {
		
		guard let panelView = panel.view else {
			return nil
		}
		
		var previewTargetFrame = panelView.bounds
		
		previewTargetFrame.origin.y = 0.0
		
		switch side {
		case .left:
			previewTargetFrame.origin.x = 0.0
		case .right:
			previewTargetFrame.origin.x = panelContentWrapperView.bounds.width - panelView.bounds.width
		}
		
		previewTargetFrame.size.height = panelContentWrapperView.bounds.height - previewTargetFrame.origin.y
		
		return previewTargetFrame
	}
	
	func updatedContentViewFrame() -> CGRect {
		
		var updatedContentViewFrame = panelContentView.frame
		
		updatedContentViewFrame.size.width = panelContentWrapperView.bounds.width
		
		updatedContentViewFrame.origin.x = 0.0
		
		if let leftPanelSize = panelPinnedLeft?.contentViewController?.preferredPanelContentSize {
			
			updatedContentViewFrame.size.width -= leftPanelSize.width
			
			updatedContentViewFrame.origin.x = leftPanelSize.width
		}
		
		if let rightPanelSize = panelPinnedRight?.contentViewController?.preferredPanelContentSize {
			
			updatedContentViewFrame.size.width -= rightPanelSize.width
			
		}
		
		return updatedContentViewFrame
	}
	
	func fadePinnedPreviewOut(for panel: PanelViewController) {
		
		if let panelPinnedPreviewView = panel.panelPinnedPreviewView {
			
			UIView.animate(withDuration: 0.3, animations: {
				panelPinnedPreviewView.alpha = 0.0
			}, completion: { (_) in
				panelPinnedPreviewView.removeFromSuperview()
			})
			
			panel.panelPinnedPreviewView = nil
		}
		
	}
	
}
