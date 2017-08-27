import React, { Component } from 'react'
import { Icon } from 'react-fa'
import cx from 'classnames'
import { gql, graphql } from 'react-apollo'
import Loading from '../../Loading'
import store from '../../../store'

const Channel = ({ id, name, messages, onSelect }) => {
  const members = messages.nodes
    .map(n => n.username)
    .filter((n, i, s) => n !== store.username && s.indexOf(n) === i)
    .sort()
  const channel = members.length > 1
  return (
    <div className={cx('item', { channel })} onClick={() => onSelect(id)}>
      <span className="name">
        <Icon name="hashtag" />
        {name.split(' ').map(w => w[0].toUpperCase() + w.slice(1)).join(' ')}
      </span>
      <span className="members">
        {members.join(', ').replace(/,\s([^,]+)$/, ' and $1')}
      </span>
      <Icon name="chevron-right" />
    </div>
  )
}

const List = ({ channels, onSelect }) =>
  <div className="list">
    {channels.map(channel => <Channel {...channel} key={channel.id} onSelect={onSelect} />)}
  </div>

const NewChat = () =>
  <button>
    <Icon name="plus" size="lg" />
  </button>

class Chat extends Component {
  componentDidMount() {
    store.menu.title = 'Chat'
    store.menu.left = null
    store.menu.right = <NewChat />
    store.showNav = true
  }

  _onSelectChat = id => {
    this.props.history.push('/chat/' + id)
  }

  render() {
    const { loading, allChannels } = this.props.data
    return (
      <div className="screen chat">
        {loading ? <Loading /> : <List onSelect={this._onSelectChat} channels={allChannels.nodes} />}
      </div>
    )
  }
}

export default graphql(gql`
  query {
    allChannels {
      nodes {
        id
        name
        messages: messagesByChatId {
          nodes {
            username
          }
        }
      }
    }
  }
`)(Chat)
