from math import sqrt
import matplotlib.pyplot as plt
import pandas as pd


#================================================================================== 
# Data Processing Functions
#===============================================================================

def print_db_data(db_data):
    for db in range(0,len(db_data)):
        for q in range(0,len(db_data[0])):
            for trial in range(0,len(db_data[0][0])):
                print(db_data[db][q][trial], end=' ')
            print('\n', end='')
        print('\n', end='')

def import_data(db_data_file, db_data, scale=True):
    for db in range(0,9):
        line_num = 0
        q1 = []
        q2 = []
        q3 = []
        q4 = []        
        db_data_temp = []
        for line in db_data_file[db].readlines():
            if line_num%4==0:
                time_val = float(line)
                if scale:
                    time_val = time_val*1000
                q1.append(time_val)
            if line_num%4==1:
                time_val = float(line)
                if scale:
                    time_val = time_val*1000
                q2.append(time_val)
            if line_num%4==2:
                time_val = float(line)
                if scale:
                    time_val = time_val*1000
                q3.append(time_val)
            if line_num%4==3:
                time_val = float(line)
                if scale:
                    time_val = time_val*1000
                q4.append(time_val)
            
            line_num = line_num+1
        
        db_data_temp.append(q1)
        db_data_temp.append(q2)
        db_data_temp.append(q3)
        db_data_temp.append(q4)
        db_data.append(db_data_temp)
        


def process_data(db_data):
    for db in range(0,9):
        for q in range(0,4):
            trials = db_data[db][q]
            # print(trials)
            max_idx=0
            max=0
            for i in range(0, len(trials)):
                if(trials[i]>max):
                    max = trials[i]
                    max_idx = i
            del trials[max_idx]
            min_idx=0
            min=trials[0]
            for i in range(0, len(trials)):
                if(trials[i]<min):
                    min = trials[i]
                    min_idx = i
            del trials[min_idx]
            # print(trials)
            trials_avg = sum(trials)/5
            trials_dev = 0
            for num in trials:
                trials_dev = trials_dev + (trials_avg-num)**2
            trials_dev = sqrt(trials_dev/5)
            db_data[db][q] = [trials_avg, trials_dev]
        # print()

#================================================================================== 
# Plotting Functions
#===============================================================================

def group_data_by_query(sqlite_data, maria_data, maria_indexed_data, mongo_data, q):
    means = []
    stds = []
    db_systems = []
    for db_data in [(sqlite_data, 'SQlite3'), (maria_data, 'MariaDB'), (maria_indexed_data, 'MariaDB(Indexed)'), (mongo_data, 'MongoDB')]:
        for i in range(0,9):
            db_systems.append(db_data[1])
            means.append(db_data[0][i][q][0])
            stds.append(db_data[0][i][q][1])
    
    return db_systems, means, stds

def plot_graphs_per_query(sqlite_data, maria_data, maria_indexed_data, mongo_data):
    datasets = []
    for dataset in ['db1', 'db2', 'db3', 'db4', 'db5', 'db6', 'db7', 'db8', 'db9']*4:
        datasets.append(dataset)
    for q in range(0,4):
        db_systems, means, stds = group_data_by_query(sqlite_data, maria_data, maria_indexed_data, mongo_data, q)
        df = pd.DataFrame({
            'datasets': datasets,
            'means': means,
            'db_systems': db_systems,
            'stds': stds})
        # print(f"Done {q+1}")
        save_graph_per_query(df, q+1)

def save_graph_per_query(df,query):
    fig, ax = plt.subplots()

    for key, group in df.groupby('db_systems'):
        group.plot('datasets', 'means', yerr='stds',
                   label=key, ax=ax)

    plt.draw()
    fig.suptitle(f'Query {query}', fontsize=16)
    plt.xlabel('Dataset', fontsize=10)
    plt.ylabel('Time (in ms)', fontsize=10)
    plt.savefig(f'plots/per_query/Query{query}.png')

def group_data_by_db_system(db_data):
    means = []
    stds = []
    queries = []
    for q in range(0,4):
        for i in range(0,9):
            queries.append(f'Query {q+1}')
            means.append(db_data[i][q][0])
            stds.append(db_data[i][q][1])
        
    return queries, means, stds
    

def plot_graphs_per_db_system(sqlite_data, maria_data, maria_indexed_data, mongo_data):
    datasets = []
    for dataset in ['db1', 'db2', 'db3', 'db4', 'db5', 'db6', 'db7', 'db8', 'db9']*4:
        datasets.append(dataset)
    for db_data in [(sqlite_data, 'SQlite3'), (maria_data, 'MariaDB'), (maria_indexed_data, 'MariaDB(Indexed)'), (mongo_data, 'MongoDB')]:
        queries, means, stds = group_data_by_db_system(db_data[0])
        df = pd.DataFrame({
            'datasets': datasets,
            'means': means,
            'queries': queries,
            'stds': stds})
        save_graph_per_db_sytem(df, db_data[1])

def save_graph_per_db_sytem(df, db_system_name):
    fig, ax = plt.subplots()

    for key, group in df.groupby('queries'):
        group.plot('datasets', 'means', yerr='stds',
                   label=key, ax=ax)

    plt.draw()
    fig.suptitle(db_system_name, fontsize=16)
    plt.xlabel('Dataset', fontsize=10)
    plt.ylabel('Time (in ms)', fontsize=10)
    plt.savefig(f'plots/per_db_system/{db_system_name}.png')

 
#================================================================================== 
# Main
#===============================================================================


sqlite_data_file = []   
mongo_data_file = []
maria_data_file = []
maria_indexed_data_file = []

sqlite_data = []
mongo_data = []
maria_data = []
maria_indexed_data = []

# Open Files
for i in range(1,10):
    sqlite_data_file.append(open('data/query_time_data/sqlite/db{0}.txt'.format(i), 'r'))
    mongo_data_file.append(open('data/query_time_data/mongodb/db{0}.txt'.format(i), 'r'))
    maria_data_file.append(open('data/query_time_data/mariadb/db{0}.txt'.format(i), 'r'))
    maria_indexed_data_file.append(open('data/query_time_data/mariadb_indexed/db{0}.txt'.format(i), 'r'))

# Import data
import_data(sqlite_data_file, sqlite_data)
import_data(maria_data_file, maria_data)
import_data(maria_indexed_data_file, maria_indexed_data)
import_data(mongo_data_file, mongo_data, False)

# Calculate mean, standard Deviation
process_data(sqlite_data)
process_data(maria_data)
process_data(maria_indexed_data)
process_data(mongo_data)

# Plot Data
plot_graphs_per_query(sqlite_data, maria_data, maria_indexed_data, mongo_data)
plot_graphs_per_db_system(sqlite_data, maria_data, maria_indexed_data, mongo_data)

# Close Files
for db in range(0,9):
    sqlite_data_file[db].close()
    mongo_data_file[db].close()
    maria_data_file[db].close()
    maria_indexed_data_file[db].close()