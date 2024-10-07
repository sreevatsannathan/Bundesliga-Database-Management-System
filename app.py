from flask import Flask, render_template, request
from db import get_db_connection

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    conn = get_db_connection()
    cur = conn.cursor()

    query = "SELECT match_date, home_team, away_team, fthg, ftag, hthg, htag FROM matches"
    filters = []
    sort_query = ""
    
    if request.method == 'POST':
        team = request.form.get('team')
        half_time_goals = request.form.get('half_time_goals')
        sort_by = request.form.get('sort_by')
        order = request.form.get('order')

        if team:
            filters.append(f"(home_team ILIKE '%{team}%' OR away_team ILIKE '%{team}%')")
        if half_time_goals:
            filters.append(f"hthg = {half_time_goals} OR htag = {half_time_goals}")
        
        if filters:
            query += " WHERE " + " AND ".join(filters)

        if sort_by:
            sort_query = f" ORDER BY {sort_by} {order}"

    query += sort_query
    cur.execute(query)
    matches = cur.fetchall()
    
    cur.close()
    conn.close()

    return render_template('index.html', matches=matches)

@app.route('/teams', methods=['GET', 'POST'])
def teams():
    conn = get_db_connection()
    cur = conn.cursor()

    # Default SQL query to fetch all teams
    query = "SELECT team_name, g_per_90, total_passes_completed, key_passes, passes_in_final_third FROM teams"
    filters = []
    sort_query = ""

    # If the user submits the search/filter form
    if request.method == 'POST':
        team = request.form.get('team')
        g_per_90 = request.form.get('g_per_90')
        total_passes_completed = request.form.get('total_passes_completed')
        key_passes = request.form.get('key_passes')
        passes_in_final_third = request.form.get('passes_in_final_third')
        sort_by = request.form.get('sort_by')
        order = request.form.get('order')

        # Apply filters
        if team:
            filters.append(f"team_name ILIKE '%{team}%'")
        if g_per_90:
            filters.append(f"g_per_90 = {g_per_90}")
        if total_passes_completed:
            filters.append(f"total_passes_completed >= {total_passes_completed}")
        if key_passes:
            filters.append(f"key_passes >= {key_passes}")
        if passes_in_final_third:
            filters.append(f"passes_in_final_third >= {passes_in_final_third}")
        
        # Combine filters into SQL WHERE clause
        if filters:
            query += " WHERE " + " AND ".join(filters)
        
        # Apply sorting
        if sort_by:
            sort_query = f" ORDER BY {sort_by} {order}"
    
    # Final query with filters and sorting
    query += sort_query

    cur.execute(query)
    teams = cur.fetchall()
    cur.close()
    conn.close()

    return render_template('teams.html', teams=teams)

if __name__ == '__main__':
    app.run(debug=True)
