﻿//
//  TestURL.swift
//  LakestoneCore
//
//  Created by Taras Vozniuk on 9/28/16.
//  Copyright © 2016 GeoThings. All rights reserved.
//
// --------------------------------------------------------
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


#if COOPER
	
	import remobjects.elements.eunit
	
#else
	
	import XCTest
	import Foundation
	
	#if os(iOS) || os(watchOS) || os(tvOS)
		@testable import LakestoneCoreIOS
	#else
		@testable import LakestoneCore
	#endif
	
#endif

class TestURL: Test {

	public func testURLUtilities(){
		
        let testPath = "/usr/path/to/some/resource.test"
        
        //Assert.IsNil(URL(string: "ººº"))
        Assert.IsNotNil(URL(string: "file://" + testPath))
        
        /*
		let url = URL(fileURLWithPath: testPath)
		Assert.AreEqual(url.path, testPath)
        Assert.AreEqual(url.lastPathComponent, "resource.test")
        Assert.AreEqual(url.pathExtension, "test")
        
        
        let rootURL = URL(fileURLWithPath: "/")
        Assert.AreEqual(rootURL.path, "/")
        Assert.AreEqual(rootURL.lastPathComponent, "/")
        Assert.AreEqual(rootURL.pathExtension, "")
        
        
        let folderPath = "/usr/path/to/some/resource/"
        let folderURL = URL(fileURLWithPath: folderPath)
        print(folderURL.pathComponents)
        Assert.AreEqual(folderURL.pathComponents, ["", "usr", "path", "to", "some", "resource", ""])
        Assert.AreEqual(folderURL.path, folderPath)
        Assert.AreEqual(folderURL.lastPathComponent, "")
        Assert.AreEqual(folderURL.pathExtension, "")
 
        */
	}
}

#if !COOPER
extension TestURL {
	static var allTests : [(String, (TestURL) -> () throws -> Void)] {
		return [
			("testURLUtilities", testURLUtilities)
		]
	}
}
#endif