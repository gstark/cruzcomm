import React, { Component } from 'react'
import { Icon } from 'react-fa'
import SimpleWebRTC from 'simplewebrtc'
import store from '../../../store'

const BackButton = props =>
  <button {...props}>
    <Icon name="chevron-left" size="lg" />
  </button>

class Video extends Component {
  state = {
    connected: false
  }

  componentDidMount() {
    store.menu.title = 'Chat'
    store.menu.left = <BackButton onClick={this._onBackButton} />
    store.menu.right = null
    store.showNav = true
    const webrtc = new SimpleWebRTC({
      localVideoEl: this.refs.ownVideo,
      remoteVideosEl: this.refs.allVideo,
      autoRequestMedia: true,
      debug: false,
      detectSpeakingEvents: true
    })

    const roomname = [store.username.toLowerCase().replace(/[^a-z0-9]/, ''), this.props.match.params.contact]
      .sort()
      .join('+')

    webrtc.on('readyToCall', () => {
      webrtc.joinRoom(roomname)
    })

    webrtc.on('videoAdded', () => {
      this.setState({ connected: true })
    })

    webrtc.on('videoRemoved', () => {
      this.setState({ connected: false })
    })

    this.webrtc = webrtc
  }

  componentWillUnmount() {
    if (this.webrtc) {
      this.webrtc.stopLocalVideo()
      this.webrtc.leaveRoom()
    }
    this.webrtc = null
  }

  _onBackButton = () => {
    this.props.history.push('/chat')
  }
  render() {
    return (
      <div className="screen video">
        <h1>
          {this.state.connected ? '' : 'Waiting for the other person.'}
        </h1>
        <div className="ownVideo" ref="ownVideo" />
        <div className="allVideo" ref="allVideo" />
      </div>
    )
  }
}

export default Video
