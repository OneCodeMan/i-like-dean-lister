import Foundation
import UIKit

protocol ComicViewDelegate {
    func handleMostRecentClicked()
    func handlePrevClicked()
    func handleNextClicked()
    func handleRandomClicked()
    func handleSelectedComicNumber(_ number: Int)
    func handleToggleFavorite()
}
