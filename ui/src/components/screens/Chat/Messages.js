import React, { Component } from 'react'
import { gql, graphql } from 'react-apollo'
import moment from 'moment'
import cx from 'classnames'
import Loading from '../../Loading'
import { Icon } from 'react-fa'
import store from '../../../store'

const BackButton = props =>
  <button {...props}>
    <Icon name="chevron-left" size="lg" />
  </button>

const Message = ({ message, username, createdAt }) =>
  <div className={cx('message', { mine: username === store.username })}>
    <div className="meta">
      <span className="author">
        {username}
      </span>
      <span className="time">
        {moment(createdAt).fromNow()}
      </span>
    </div>
    <div className="content">
      {message}
    </div>
  </div>

class NewMessage extends Component {
  _submit = event => {
    event.preventDefault()
    this.props
      .mutate({
        variables: {
          chatId: this.props.id,
          username: store.username,
          message: this.refs.message.value
        }
      })
      .then(({ data }) => {
        this.refs.message.value = ''
        this.props.refetch()
      })
  }
  render() {
    return (
      <form className="text" onSubmit={this._submit}>
        <input type="text" ref="message" />
        <button type="submit">Send</button>
      </form>
    )
  }
}
const submitMessage = gql`
  mutation($chatId: Int!, $message: String!, $username: String!) {
    createMessage(input: { message: { message: $message, chatId: $chatId, username: $username } }) {
      clientMutationId
    }
  }
`
const NewMessageWithData = graphql(submitMessage)(NewMessage)

class Messages extends Component {
  componentDidMount() {
    store.menu.title = 'Loading Chat'
    store.menu.left = <BackButton onClick={this._onBackButton} />
    store.menu.right = null
    store.showNav = true
  }

  _onBackButton = () => {
    this.props.history.push('/chat')
  }

  componentWillReceiveProps(nextProps) {
    const { channel, loading } = nextProps.data
    if (!loading) {
      const members = channel.messages.nodes
        .map(n => n.username)
        .filter((n, i, s) => n !== store.username && s.indexOf(n) === i)
      const title = (
        <span>
          <Icon name="hashtag" />&nbsp;
          {channel.name.split(' ').map(w => w[0].toUpperCase() + w.slice(1)).join(' ')}
        </span>
      )
      store.menu.title = members.length > 1 ? title : `Chat with ${members}`
    }
  }

  componentDidUpdate(prevProps, prevState) {
    document.body.scrollTop = document.body.scrollHeight
  }

  messages() {
    return this.props.data.channel.messages.nodes.map(message => <Message {...message} key={message.id} />)
  }

  render() {
    const { channel, loading, refetch } = this.props.data
    return (
      <div className="screen chat messages">
        <main>
          {loading ? <Loading /> : this.messages()}
        </main>
        {loading ? null : <NewMessageWithData {...channel} refetch={refetch} />}
      </div>
    )
  }
}

export default graphql(
  gql`
    query($id: Int!) {
      channel: channelById(id: $id) {
        id
        name
        messages: messagesByChatId {
          nodes {
            id
            message
            username
            createdAt
          }
        }
      }
    }
  `,
  {
    options: props => ({
      variables: {
        id: props.match.params.channelId
      },
      pollInterval: 1000
    })
  }
)(Messages)
