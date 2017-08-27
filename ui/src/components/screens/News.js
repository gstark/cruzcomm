import React, { Component } from 'react'
import { gql, graphql } from 'react-apollo'
import moment from 'moment'
import { Icon } from 'react-fa'
import cx from 'classnames'
import store from '../../store'
import Loading from '../Loading'

class Story extends Component {
  state = {
    expanded: false
  }

  _toggle = () => {
    this.setState({
      expanded: !this.state.expanded
    })
  }

  render() {
    const { expanded } = this.state
    const { category, headline, publishedAt, body } = this.props
    return (
      <div className="story">
        <header onClick={this._toggle}>
          <h3 className="category">
            {category}
          </h3>
          <h2 className="title">
            {headline}
          </h2>
          <div className="meta">
            <span className="time">
              {moment(publishedAt).format('MMMM Do YYYY @ h:mm:ss a')}
            </span>
            <span>
              <Icon name={expanded ? 'chevron-up' : 'chevron-down'} />
            </span>
          </div>
        </header>
        <article className={cx('content', { expanded })}>
          {body.split(/\n+/).map((paragraph, i) =>
            <p key={i}>
              {paragraph}
            </p>
          )}
        </article>
      </div>
    )
  }
}

class News extends Component {
  componentDidMount() {
    store.menu.title = 'World News'
    store.menu.left = null
    store.menu.right = null
    store.showNav = true
    document.body.scrollTop = 0
  }

  // headline: String!
  // category: String!
  // body: String!
  // publishedAt: Datetime!

  stories() {
    return this.props.data.allWorldNewsArticles.nodes.map(story => <Story {...story} key={story.id} />)
  }

  render() {
    const { loading } = this.props.data
    return (
      <div className="screen news">
        <div className="list">
          {loading ? <Loading /> : this.stories()}
        </div>
      </div>
    )
  }
}

export default graphql(gql`
  query {
    allWorldNewsArticles {
      nodes {
        id
        headline
        body
        publishedAt
        category
      }
    }
  }
`)(News)
