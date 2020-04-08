//
//  Area.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public enum Area: CaseIterable {

    case hokkaido
    case tohoku
    case kanto
    case chubu
    case kinki
    case chugoku
    case shikoku
    case kyushu

   public var name: String {
        switch self {
        case .hokkaido:
            return "北海道"
        case .tohoku:
            return "東北"
        case .kanto:
            return "関東"
        case .chubu:
            return "中部"
        case .kinki:
            return "近畿"
        case .chugoku:
            return "中国"
        case .shikoku:
            return "四国"
        case .kyushu:
            return "九州"
        }
    }

    public var id: Int {
        switch self {
        case .hokkaido:
            return 0
        case .tohoku:
            return 1
        case .kanto:
            return 2
        case .chubu:
            return 3
        case .kinki:
            return 4
        case .chugoku:
            return 5
        case .shikoku:
            return 6
        case .kyushu:
            return 7
        }
    }
}
