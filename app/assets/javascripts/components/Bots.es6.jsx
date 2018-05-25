class Bots extends React.Component {
  render () {
    return (
      <div className="container">
        { this.props.bots.map(
            (bot) => (
              <Bot key={bot.id} bot={bot} />
            )
          )
        }
      </div>
    );
  }
}

Bots.propTypes = {
  bots: PropTypes.array
};

