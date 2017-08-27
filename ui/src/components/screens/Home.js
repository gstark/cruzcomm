import React, { Component } from 'react'
import store from '../../store'
import { Icon } from 'react-fa'

class Home extends Component {
  componentDidMount() {
    store.showNav = false
  }

  _onSignIn = () => {
    store.username = this.refs.username.value
    // window.localStorage.setItem('cc:username', store.username)
    this.props.history.push('/call')
  }

  render() {
    return (
      <div className="screen home">
        <div className="login">
          <Icon name="ship" size="3x" />
          <input type="text" ref="username" />
          <button onClick={this._onSignIn}>Sign In</button>
        </div>

        <div className="video-cover">
          <video autoPlay loop muted>
            <source src="/ship.mp4" type="video/mp4" />
          </video>
        </div>
      </div>
    )
  }
}

export default Home
