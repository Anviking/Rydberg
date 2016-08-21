import Foundation

//
//  SJLatexView.swift
//  LatexView
//
//  Created by Shunji Li  on 8/4/15.
//  Copyright © 2015 Shunji Li . All rights reserved.
//

import Foundation
import UIKit

public class SJLatexView: UIWebView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.scrollView.isScrollEnabled = false
    }
    
    public init(latex: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        loadLatexString(latexString: latex)
    }
    
    public func loadLatexString(latexString: String) {
        loadHTMLString(contentHtmlWithLatexString(latexString: latexString), baseURL: nil)
    }
    
    private func mathJaxScript() -> String {
        return "<script src='https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'></script>"
    }
    
    private func configScript() -> String {
        return "<script type=\"text/x-mathjax-config\">"
            + "MathJax.Hub.Config({jax: [\"input/TeX\",\"output/HTML-CSS\"], tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]} , \"HTML-CSS\": {linebreaks: {automatic: true}}});"
            + "</script>"
    }
    
    private func contentHtmlWithLatexString(latexString: String) -> String {
        let header = configScript() + mathJaxScript()
        return "<html><header>\(header)</header><body>\(latexString)</body></html>"
    }
}
