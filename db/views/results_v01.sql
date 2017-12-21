SELECT
  tournament_id,
  competitor_id,
  array_agg(result) AS total
FROM
  (
    SELECT
      tournament_id,
      competitor_id,
      sum(value) AS result
    FROM players
      JOIN rounds ON rounds.id = players.round_id
      JOIN tournaments ON tournaments.id = rounds.tournament_id,
          unnest(players.result_values) WITH ORDINALITY AS arr(value, index)
    GROUP BY
      tournament_id,
      competitor_id,
      index
    ORDER BY
      competitor_id,
      index
  ) AS summary
GROUP BY tournament_id, competitor_id
ORDER BY total DESC
