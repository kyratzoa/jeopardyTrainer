//
//  Clues.swift
//  JeopardyTrainer
//
//  Created by Anastasia on 12/15/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON
import Alamofire

class Clues {
    var id = 0 // the category ID
    var cluesCount = 0 // # of clues
    var clueArray: [Clue] = [] // array that holds clues
    var apiURL = "http://jservice.io/api/category/?id="
    
    func getData(completed: @escaping () -> () ) {
        Alamofire.request(apiURL+"\(id)").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfClues = json["clues"].count
                for index in 0..<numberOfClues {
                    let clue = Clue()
                    clue.question = json["clues"][index]["question"].stringValue
                    clue.answer = json["clues"][index]["answer"].stringValue
                    clue.categoryID = json["clues"][index]["category_id"].intValue
                    clue.value = json["clues"][index]["value"].intValue
                    clue.clueID = json["clues"][index]["id"].intValue
                    self.clueArray.append(clue)
                }
            case .failure(let error):
                print("😡😡 ERROR: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
    }
}
