//
//  JsonPropertys.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 25/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

enum JsonPropertys {

	case identifier
	case labelIdentifier
	case name
	case title
	case stars
	case fork
	case user
	case login
	case avatar
	case html
	case body
	case created
	case owner
	case description
	case items
	case empty
	case yyyyMMddTHHmmssZ
	case ddMMyyyyHHmmss

	var content: String{

		switch self  {

		case .identifier: return "id"
		case .name: return "name"
		case .title: return "title"
		case .stars: return "stargazers_count"
		case .fork: return "forks_count"
		case .user: return "user"
		case .login: return "login"
		case .avatar: return "avatar_url"
		case .html: return "html_url"
		case .body: return "body"
		case .created: return "created_at"
		case .owner: return "owner"
		case .description: return "description"
		case .items: return "items"
		case .empty: return ""
		case .labelIdentifier: return "identifier"
		case .yyyyMMddTHHmmssZ: return "yyyy-MM-dd'T'HH:mm:ssZ"
		case .ddMMyyyyHHmmss: return "dd/MM/yyyy HH:mm:ss"
		}
	}

//	static let allValues = [name, title, stars, forks, user, login, avatar, html, body, created, owner, description]
}

/*



*/
