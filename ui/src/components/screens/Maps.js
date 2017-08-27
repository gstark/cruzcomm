import React, { Component } from 'react'
import store from '../../store'

class Maps extends Component {
  componentDidMount() {
    store.menu.title = 'Locator'
    store.menu.left = null
    store.menu.right = null
    store.showNav = true
    document.body.scrollTop = 0
  }

  render() {
    return (
      <div className="screen maps">
        <div className="deck">
          <img src="/images/deck_1.png" alt="Deck 1" />
        </div>
        <div className="deck">
          <img src="/images/deck_2.png" alt="Deck 2" />
        </div>
        <div className="deck">
          <img src="/images/deck_3.png" alt="Deck 3" />
        </div>
        <div className="deck">
          <img src="/images/deck_4.png" alt="Deck 4" />
        </div>
        <div className="deck">
          <img src="/images/deck_5.png" alt="Deck 5" />
        </div>
        <div className="deck">
          <img src="/images/deck_6.png" alt="Deck 6" />
        </div>
        <div className="deck">
          <img src="/images/deck_7.png" alt="Deck 7" />
        </div>
        <div className="deck">
          <img src="/images/deck_8.png" alt="Deck 8" />
        </div>
        <div className="deck">
          <img src="/images/deck_9.png" alt="Deck 9" />
        </div>
        <div className="deck">
          <img src="/images/deck_E.png" alt="Deck E" />
        </div>
      </div>
    )
  }
}

export default Maps
